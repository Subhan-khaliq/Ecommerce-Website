# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # include SessionsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart
  skip_before_action :verify_authenticity_token

  private

  def set_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      cart.present? ? (@current_cart = cart) : (session[:cart_id] = nil)
    end
    return unless session[:cart_id].nil?

    @current_cart = Cart.create(user_id: nil)
    session[:cart_id] = @current_cart.id
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email first_name last_name encrypted_password avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email first_name last_name encrypted_password avatar])
  end
end
