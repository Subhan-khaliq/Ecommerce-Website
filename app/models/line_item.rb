# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    quantity.to_s.to_d * product.price.to_s.to_d
  end
end
