# frozen_string_literal: true

# Monkeypatch clarat_base SolutionCategory
require ClaratBase::Engine.root.join('app', 'models', 'solution_category')

class SolutionCategory < ApplicationRecord
  # Search
  include PgSearch
  pg_search_scope :search_pg,
                  against: %i[id name],
                  using: { tsearch: { prefix: true } }

  # Methods

  # alias for rails_admin_nestable
  # singleton_class.send :alias_method, :arrange, :hash_tree

  include ReformedValidationHack
end
