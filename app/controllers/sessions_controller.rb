class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  # this before_action blocks sign-in if already logged in:
  before_action :redirect_if_logged_in, only: [ :new, :create ]

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Welcome! You have signed in successfully."
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    flash[:notice] = "You have been signed out."
    redirect_to new_session_path
  end

  private

  def redirect_if_logged_in
    if Current.user.present?
      redirect_to root_path, alert: "You are already signed in."
    end
  end
end
