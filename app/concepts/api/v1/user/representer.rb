# frozen_string_literal: true

module API::V1
  module User
    module Representer
      class Show < Roar::Decorator
        include Roar::JSON::JSONAPI.resource :users

        attributes do
          property :label, getter: ->(user) do
            user[:represented].name
          end
          property :name
          property :email
          property :role
          property :active

          property :user_team_ids
          property :led_team_ids
          property :observed_user_team_ids
        end
      end

      class Index < Show
      end

      class Update < Roar::Decorator
        include Roar::JSON::JSONAPI.resource :users

        attributes do
          property :name
          property :email
          property :role
        end

        has_many :user_teams, class: ::UserTeam do
          type :user_teams

          attributes do
            property :label, getter: ->(o) { o[:represented].name }
            property :name
            property :classification
            property :lead_id
            property :parent_id
            property :user_ids
            property :observing_user_ids
          end
        end

        has_many :led_teams, class: ::UserTeam do
          type :user_teams

          attributes do
            property :label, getter: ->(o) { o[:represented].name }
            property :name
            property :classification
            property :lead_id
            property :parent_id
            property :user_ids
            property :observing_user_ids
          end
        end

        has_many :observed_user_teams, class: ::UserTeam do
          type :user_teams

          attributes do
            property :label, getter: ->(o) { o[:represented].name }
            property :name
            property :classification
            property :lead_id
            property :parent_id
            property :user_ids
            property :observing_user_ids
          end
        end

        # collection :created_assignments do
        #   property :id
        #   property :message, as: :label
        # end
        #
        # collection :received_assignments do
        #   property :id
        #   property :message, as: :label
        # end
      end
    end
  end
end
