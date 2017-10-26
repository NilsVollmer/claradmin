# frozen_string_literal: true

require_relative './sync_organization.rb'
class Division::Create < Trailblazer::Operation
  include SyncOrganization
  include Assignable::CommonSideEffects::CreateNewAssignment

  step Model(::Division, :new)
  step Policy::Pundit(PermissivePolicy, :create?)

  step Contract::Build(constant: Division::Contracts::Create)
  step Contract::Validate()
  step Wrap(::Lib::Transaction) {
    step ::Lib::Macros::Nested::Create(:websites, Website::Create)
    step ::Lib::Macros::Nested::Find(:section, ::Section)
    step ::Lib::Macros::Nested::Find(:city, ::City)
    step ::Lib::Macros::Nested::Find(:area, ::Area)
    step ::Lib::Macros::Nested::Find(:organization, ::Organization)
    step ::Lib::Macros::Nested::Find(:presumed_tags, ::Tag)
    step ::Lib::Macros::Nested::Find(
      :presumed_solution_categories, ::SolutionCategory
    )
  }
  step Contract::Persist()
  step :create_initial_assignment!
  step :syncronize_organization_approve_or_done_state
end
