class UsersController < ApplicationController
  before_filter :authorize

  def show
    @user = User.find(params[:id])
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
    # @start_date = Date.civil(params[:range][:"start_date(1i)"].to_i,params[:range][:"start_date(2i)"].to_i,params[:range][:"start_date(3i)"].to_i)
  end

  def drawdown
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to get_login_path()
    else
      if @user.media_id.nil? || @user.media_id == 0
        flash[:error] = 'Mời bạn Upload CMT/Hộ chiếu ở Tab Tài khoản trước khi sử dụng chức năng Đề nghị vay'
        redirect_to user_path()
      else
        @sponsors = Sponsor.all
        @banks = Bank.where('parent_id =?', 0)
        @drawdown = Drawdown.where('user_id = ? AND is_draft = ?', params[:id], 1).first
        
        if request.request_method() == 'PATCH'
          flag = proccess_drawdown(params)
          if flag != false
            flash[:success] = 'Cap nhat de nghi vay thanh cong'
          else
            flash[:error] = 'Error'
          end
        end

        if request.request_method() == 'POST'

          flag = proccess_drawdown(params)
          if flag != false
            flash[:success] = 'De nghi vay da duoc gui di. Chung toi se duyet de nghi cua ban trong thoi gian som nhat'
          else
            flash[:error] = 'Error'
          end
        else
          if @drawdown.nil?
            @drawdown = Drawdown.new
          end
        end
      end
    end
  end


  def proccess_drawdown(params)
    draft = params[:draft]
    flag = false
    if draft.to_i == 1.to_i
      if @drawdown.nil?
        flag = save_drawdown(params)
      else
        flag = update_drawdown(@drawdown, params, 1)
      end
    else
      if @drawdown.nil?
        flag = save_drawdown(params)
      else
        flag = update_drawdown(@drawdown, params, 0)
      end
    end
    return flag
  end



  def save_drawdown(params)
    @drawdown = Drawdown.new(drawdown_params)
    @drawdown.user_id = session[:user_id]
    @drawdown.is_draft = params[:draft];
    if @drawdown.save
      if params[:media_contract_id]
        media = Medium.create(path: params[:media_contract_id])
        @drawdown.update(:media_contract_id => media.id)
      end

      if params[:media_appoint_id]
        media = Medium.create(path: params[:media_appoint_id])
        @drawdown.update(:media_appoint_id => media.id)
      end

      if params[:media_salary_id]
        media = Medium.create(path: params[:media_salary_id])
        @drawdown.update(:media_salary_id => media.id)
      end
      return true
    else
      return false
    end
  end

  def update_drawdown(drawdown, params, is_draft)
    if drawdown.update(drawdown_params)
      drawdown.update(:is_draft => is_draft)
      if params[:media_contract_id]
        media = Medium.create(path: params[:media_contract_id])
        @drawdown.update(:media_contract_id => media.id)
      end

      if params[:media_appoint_id]
        media = Medium.create(path: params[:media_appoint_id])
        @drawdown.update(:media_appoint_id => media.id)
      end

      if params[:media_salary_id]
        media = Medium.create(path: params[:media_salary_id])
        @drawdown.update(:media_salary_id => media.id)
      end
      return true
    end
    return false
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

  def draff

  end
  private
  def user_params
    params.require(:user).permit(:email,:password,:name,:birthday,:phone,:passport,:gender,:marriage,:address,:provined_id,:district_id,:ward_id)
  end

  private
  def drawdown_params
    params.require(:drawdown).permit(:sponsor_id, :contract_date, :media_contract_id, :contract_time, :position, :media_appoint_id, :appoint_in_contract, :salary, :media_salary_id, :amount, :amount_time, :purpose, :pay_time, :account_holders, :account_number, :bank_id, :branch_id, :user_id, :is_draft)
  end


end
