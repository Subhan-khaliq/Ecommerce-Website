# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: %i[create edit]
    # before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up

    # POST /resource

    # GET /resource/edit

    # PUT /resource

    # DELETE /resource
    # def new
    #   @user = User.new
    # end

    # def create
    #   @user = User.new(blog_params)

    #   if @user.save
    #     redirect_to @user
    #   else
    #     render 'new'
    #   end
    # end

    # def edit; end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name email encrypted_password avatar {role_ids: []} ])
    end
    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.

    # The path used after sign up for inactive accounts.
  end
end
