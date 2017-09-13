# frozen_string_literal: true
module API::V1
  module SplitBase
    class Create < ::SplitBase::Create
      extend Trailblazer::Operation::Representer::DSL
      representer API::V1::SplitBase::Representer::Create
    end
  end
end