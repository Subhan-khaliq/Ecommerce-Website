# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  # POST
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if authenticated?(user)
      perform_authenticated_action(user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def logout; end
end
