# frozen_string_literal: true
class OfferTranslation::Create < Trailblazer::Operation
  include Assignable::CommonSideEffects::InitialAssignment

  step Model(::OfferTranslation, :new)

  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()
  step :create_initial_assignment!
  step :reindex_offer

  extend Contract::DSL
  contract do
    property :name
    property :description
    property :opening_specification
    property :source
    property :locale
    property :possibly_outdated
    property :offer_id
  end

  def reindex_offer(*, model:, **)
    model.offer.reload.algolia_index!
  end
end