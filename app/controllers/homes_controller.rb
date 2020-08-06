class HomesController < ApplicationController
  before_action :correct_user, only: [:top]
  def top
  end

  private
  def correct_user
	     if user_signed_in?
	       redirect_to user_path(current_user.id)
	     end
  end
end
