class RegisterController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # binding.pry
    @params = params[:user]
    @user = User.new(:email => @params['email'], :active_code => rand(111111...999999),:status => 0)
    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        RegisterMailer.register_email(@user).deliver_now

        format.html { redirect_to(get_register_path, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    #send email and active_code
  end

  def active_code

  end


  def create_active_code
    @result = User.check_active_code(user_params)
    if @result
      #check success
      @result.update(:status => 1)
      current_user = $result
      # session[:user_id] = @result.id
      redirect_to user_path(@result.id), notice: "Register successfully"
    else
      #check false
    end
  end
  private
  def user_params
    params.require(:user).permit(:email,:active_code)
  end
end
