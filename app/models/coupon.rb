# frozen_string_literal: true

class Coupon < ApplicationRecord
  validates :code, uniqueness: true

  has_many :orders
end
