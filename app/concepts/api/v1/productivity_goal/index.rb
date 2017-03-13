# frozen_string_literal: true
module API::V1
  module ProductivityGoal
    class Index < API::V1::Default::Index
      def base_query
        ::ProductivityGoal
      end
    end
  end
end