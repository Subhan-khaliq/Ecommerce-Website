# frozen_string_literal: true

class Cart < ApplicationRecord
  include Calculatable

  has_many :line_items
  has_many :products, through: :line_items


end
