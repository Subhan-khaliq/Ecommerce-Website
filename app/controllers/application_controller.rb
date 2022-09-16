# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  skip_before_action :verify_authenticity_token

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email first_name last_name encrypted_password avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email first_name last_name encrypted_password avatar])
  end
end
