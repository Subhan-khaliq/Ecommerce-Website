# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product

  def total_price
    quantity.to_d * product.price.to_d
  end

end
