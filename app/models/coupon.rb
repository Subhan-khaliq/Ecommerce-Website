# frozen_string_literal: true

class Coupon < ApplicationRecord
  has_many :orders

  validates :code, uniqueness: true
end
