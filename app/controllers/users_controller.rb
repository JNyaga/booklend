class UsersController < ApplicationController
  before_action :require_authentication

  def profile
    @borrowings = Current.user.borrowings.includes(:book).where(returned: false)
  end
end
