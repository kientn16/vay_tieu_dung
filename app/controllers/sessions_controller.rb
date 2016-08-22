class SessionsController < ApplicationController
  def new
  end

  def create
  end

  def create_face
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to get_register_path
  end

  def create_google
    user = User.from_omniauth_google(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to get_register_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to get_register_path
  end
end
