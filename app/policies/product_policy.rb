# frozen_string_literal: true

class ProductPolicy
  attr_reader :user, :product

  def initialize(user, product)
    @user = user
    @product = product
  end

  def update?
    @user.has_role? :buyer
  end
end
