# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart = @current_cart
  end

  private

  def cart_params
    params.require(:cart).permit(:user_id)
  end
end
