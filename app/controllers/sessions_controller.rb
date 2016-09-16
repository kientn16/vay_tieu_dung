class SessionsController < ApplicationController
  # prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.
  def new
    # a = Digest::MD5.hexdigest('123123')
    # render :json => a
    # return

  end

  def login_admin
    # test
    # admin_root_admin_path
    # binding.pry
    #conflict
  end
  
  def create
    # binding.pry
      @data, @message = User.authenticate(params[:email], params[:password])
      if @message[:error].present?
        redirect_to new_user_session_path, :flash => { :error => @message[:error] }
      else
        session[:user_id] = @data.id
        redirect_to users_path
      end
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
    current_user = user
    render :json => current_user
    return
    redirect_to users_path
  end

  def create_google
    user = User.from_omniauth_google(env["omniauth.auth"],current_user)
    # binding.pry
    current_user = user
    redirect_to users_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def destroy_admin
    session[:admin_id] = nil
    redirect_to get_login_admin_path
  end

  def forgot_password

  end


  private
  def check_captcha
    unless verify_recaptcha

      redirect_to new_user_session_path,:flash => { :recaptcha_error => "Captcha invalid" }
    end
  end
end
