# frozen_string_literal: true

module Website::Contracts
  class Create < Reform::Form
    property :host
    property :url
    property :unreachable_count

    # TODO: Is there any way to get DRY validations to work?
    # validation do
    #   required(:host).filled
    # end

    validates :host, presence: true, inclusion: { in: ::Website::HOSTS }
    validates :url, format: %r{\Ahttps?://\S+\.\S+\z}, presence: true
    validates_uniqueness_of :url
    validates :unreachable_count, presence: true
  end

  class Update < Create
    property :id, writeable: false
  end
end
