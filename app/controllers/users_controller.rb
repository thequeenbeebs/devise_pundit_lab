class UsersController < ApplicationController
  def show
    if current_user.id != params[:id].to_i
      redirect_to root_path, flash: { error: "Access denied." }
    end
    @user = current_user
  end
end
