class SessionsController < ApplicationController
  def new
  end

  def login_admin
    # admin_root_admin_path
    # binding.pry
  end
  def create
  end

  def create_admin
    admin = Admin.authenticate(params[:username],params[:password])
    if admin
      session[:admin_id] = admin.id
      redirect_to admin_root_admin_path
    else
      redirect_to get_login_admin_path,:flash => { :error => "Username or Password invalid" }
    end
  end
  def create_face
    user = User.from_omniauth(env["omniauth.auth"],current_user)
    session[:user_id] = user.id
    redirect_to user_path(user.id)
  end

  def create_google
    user = User.from_omniauth_google(env["omniauth.auth"],current_user)
    session[:user_id] = user.id
    redirect_to user_path(user.id)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def destroy_admin
    session[:admin_id] = nil
    redirect_to get_login_admin_path
  end
end
