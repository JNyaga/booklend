class RegistrationsController < ApplicationController
  # This allows non-logged-in users to reach new/create
  allow_unauthenticated_access only: [ :new, :create ]
  before_action :resume_session, only: [ :new, :create ]

  # ➜ this before_action to blocks sign-up if already logged in:
  before_action :redirect_if_logged_in, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to root_path, notice: "Welcome! You have signed up successfully."
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def redirect_if_logged_in
    # If the user is already logged in, send them away
    if Current.user.present?
      redirect_to root_path, alert: "You are already signed in."
    end
  end

  # using Rails' built-in strong parameters syntax:
  def user_params
    # used params.expect, consider switching to require/permit:
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
