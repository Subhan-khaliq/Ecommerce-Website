# frozen_string_literal: true

class Order < ApplicationRecord
  include Calculatable

  belongs_to :user

  has_many :line_items, dependent: :destroy

  def percent_of(percent, number)
    percentage = percent * 100.0
    percentage.to_d / 100.0 * number
  end
end
