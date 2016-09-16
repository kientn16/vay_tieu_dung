class Users::ActivesController < ApplicationController

  # private

  # def sign_up_params
  #   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  # end

  # def account_update_params
  #   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  # end

  def active_code

  end

  def create_active_code
    @result = User.check_active_code(user_active_params)
    if @result
      #check success
      @result.update_column(:status, 1)
      redirect_to root_path, notice: "Register successfully"
    else
      #check false
    end
  end

  private
  def user_active_params
    params.require(:user).permit(:email,:active_code)
  end
end
