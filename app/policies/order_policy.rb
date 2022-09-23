# frozen_string_literal: true
class OrderPolicy
  attr_reader :user, :order

  def initialize(user, order)
    @user = user
    @order = order
  end

  def create?
    @user.has_role? :buyer
  end
end
