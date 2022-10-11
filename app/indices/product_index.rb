# frozen_string_literal: true

ThinkingSphinx::Index.define :product, with: :active_record do
  indexes name
  indexes quantity
end
