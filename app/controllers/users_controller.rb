class UsersController < ApplicationController
  before_filter :authorize

  def index
    @menu_active = 'user'
    @numberNotification = Notification.get_notifications(0, session[:user_id]).count
    @user = User.find(session[:user_id])
    @birthday = @user.birthday
    if @birthday == nil
      @day = Time.now.day
      @month = Time.now.month
      @year = Time.now.year
    else
      @time = @birthday.split("/")
      @day = @time[0]
      @month = @time[1]
      @year = @time[2]
    end
  end

  def update
    @user = User.find(params[:id])
    @birthday = params[:date]['day']+"/"+params[:date]['month']+"/"+params[:date]['year']
    @params = params[:user]
    @params['birthday'] = @birthday
    respond_to do |format|
      # check change email
      if @user.by_social == 1
        if user_params['email'] != @user.email
          # ko dc phep doi tiep
          @user_params = user_params.merge(change_email: 1)
          @user_update = @user.update(@user_params)
        else
          # dc phep doi tiep
          @user_params = user_params.merge(change_email: 0)
          @user_update = @user.update(@user_params)
        end
      else
        @user_update = @user.update(user_params)
      end
      if @user_update
        # upload document user here
        if params[:document]
          @media = Medium.create(path: params[:document])
          @user.update(:media_id => @media.id)
        end
        format.html {redirect_to users_path, notice: 'User was successfully updated'}
        format.json { render :index, status: :ok, location: @user}
      else
        format.html { render :index }
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def draff

  end

  def notifications
    # render :json => params
    # return
    notification_id = params[:notification_id]
    if !notification_id.nil?
      @notification = Notification.find(notification_id)
      if !@notification.nil?
        @notification.update(:is_read => 1)
      end
    end
    @notifications = Notification.get_all(params)
    @numberNotification = Notification.get_notifications(0, session[:user_id]).count
  end


  # select district
  def select_district
    @datas = Province.where('parent_id =?', params[:province_id])
    render json: @datas
  end


  private
  def user_params
    params.require(:user).permit(:email,:password,:name,:birthday,:phone,:passport,:gender,:marriage,:address,:provined_id,:district_id,:ward_id)
  end


end
