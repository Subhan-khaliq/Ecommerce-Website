# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  belongs_to :user

  def sub_total
    sum = 0
    line_items.each do |line_item|
      sum += line_item.total_price
    end
    sum
  end
end
