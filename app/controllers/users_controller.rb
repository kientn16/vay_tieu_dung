class UsersController < ApplicationController
  before_filter :authorize
  def show
    @user = User.find(params[:id])
    # @start_date = Date.civil(params[:range][:"start_date(1i)"].to_i,params[:range][:"start_date(2i)"].to_i,params[:range][:"start_date(3i)"].to_i)
  end

  def update
    @user = User.find(params[:id])
    @birthday = params[:date]['day']+"/"+params[:date]['month']+"/"+params[:date]['year']

    @params = params[:user]
    @params['birthday'] = @birthday
    # binding.pry
    respond_to do |format|
      if @user.update(user_params)
        # upload document user here
        if params[:document]
          # binding.pry
          @media = Medium.create(path: params[:document])
          @user.update(:media_id => @media.id)
        end
        format.html {redirect_to @user, notice: 'User was successfully updated'}
        format.json { render :show, status: :ok, location: @user}
      else
        format.html { render :show }
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:email,:password,:name,:birthday,:phone,:passport,:gender,:marriage,:address,:provined_id,:district_id,:ward_id)
  end
end
