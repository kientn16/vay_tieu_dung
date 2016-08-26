class UsersController < ApplicationController
  before_filter :authorize

  def show
    @numberNotification = Notification.get_notifications(0, session[:user_id]).count
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
    @numberNotification = Notification.get_notifications(0, session[:user_id]).count
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
        # binding.pry
        if request.request_method() == 'PATCH'
          params[:drawdown][:appoint_in_contact] = params[:drawdown][:appoint_in_contact] != nil ? params[:drawdown][:appoint_in_contact] : 0
          params[:drawdown][:contract_time] = params['day']+"/"+params['month']+"/"+params['year']
          flag = proccess_drawdown(params)
          if flag != false
            flash[:success] = 'De nghi vay da duoc gui di. Chung toi se duyet de nghi cua ban trong thoi gian som nhat'
            redirect_to drawdown_path()
          else
            flash[:error] = 'Error'
          end
        end

        if request.request_method() == 'POST'
          params[:drawdown][:appoint_in_contact] = params[:drawdown][:appoint_in_contact] != nil ? params[:drawdown][:appoint_in_contact] : 0
          params[:drawdown][:contract_time] = params['day']+"/"+params['month']+"/"+params['year']
          flag = proccess_drawdown(params)
          if flag != false
            flash[:success] = 'De nghi vay da duoc gui di. Chung toi se duyet de nghi cua ban trong thoi gian som nhat'
            redirect_to drawdown_path()
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
        flag = save_drawdown(params, false)
      else
        flag = update_drawdown(@drawdown, params, 1, false)
      end
      if flag == true
        contract = proccess_contract(@drawdown, session[:user_id], 99)
        history = create_history(contract, session[:user_id])
        notification = create_notification(session[:user_id], "Da luu tam de nghi vay", "Ban da luu tam de nghi vay")
      end
    else
      if @drawdown.nil?
        flag = save_drawdown(params, true)
      else
        flag = update_drawdown(@drawdown, params, 0, true)
      end
      if flag == true
        contract = proccess_contract(@drawdown, session[:user_id], 1)
        history = create_history(contract, session[:user_id])
        notification = create_notification(session[:user_id], "Da gui de nghi vay", "Ban da gui de nghi vay, Dang cho xu ly")
      end
    end
    return flag
  end

  def proccess_contract(drawdown, user_id, status)
    contract = Contract.where('drawdowns_id = ? AND user_id = ?', drawdown.id, user_id).first
    if contract.nil?
      contract = Contract.create(:code => 'HD-' + user_id.to_s + '-' + Time.now.strftime('%s').to_s, :value => drawdown.amount, :deadline => drawdown.amount_time, :status => status, :drawdowns_id => drawdown.id, :loans_time => drawdown.created_at, :user_id => user_id)
      return contract
    else
      if contract.status != 2 && contract.status != 4 && contract.status != 5
        if contract.update(:status => status)
          return contract
        end
      end
      return nil
    end
  end

  def create_history(contract, user_id)
    if !contract.nil?
      history = History.create(:contract_id => contract.id, :status_contract => contract.status, :summery => contract.value, :user_id => user_id)
    else
      nil
    end
  end

  def create_notification(user_id, title, content)
    notification = Notification.create(:user_id => user_id, :title => title, :content => content, :is_read => 0 )
  end



  def save_drawdown(params, validate)
    params[:drawdown][:appoint_in_contract] = 0
    listMedia = []
    if params[:media_contract_id]
      media = Medium.create(path: params[:media_contract_id])
      params[:drawdown][:media_contract_id] = media.id
      listMedia << media.id
    end

    if params[:media_appoint_id]
      media = Medium.create(path: params[:media_appoint_id])
      params[:drawdown][:media_appoint_id] = media.id
      listMedia << media.id
    end

    if params[:media_salary_id]
      media = Medium.create(path: params[:media_salary_id])
      params[:drawdown][:media_salary_id] = media.id
      listMedia << media.id
    end
    @drawdown = Drawdown.new(drawdown_params)
    @drawdown.user_id = session[:user_id]
    @drawdown.is_draft = params[:draft];
    # @drawdown.contract_date = params[:contract_date]
    @drawdown.is_validate = validate
    check = @drawdown.valid?
    if check == false
      Medium.delete(listMedia)
      return false
    else
      if @drawdown.save
        return true
      else
        return false
      end
    end

  end

  def update_drawdown(drawdown, params, is_draft, validate)
    drawdown.is_validate = validate
    listMedia = []
    if params[:media_contract_id]
      media = Medium.create(path: params[:media_contract_id])
      params[:drawdown][:media_contract_id] = media.id
      listMedia << media.id
    end

    if params[:media_appoint_id]
      media = Medium.create(path: params[:media_appoint_id])
      params[:drawdown][:media_appoint_id] = media.id
      listMedia << media.id
    end

    if params[:media_salary_id]
      media = Medium.create(path: params[:media_salary_id])
      params[:drawdown][:media_salary_id] = media.id
      listMedia << media.id
    end
    params[:drawdown][:is_draft] = is_draft
    
    if drawdown.update(drawdown_params)
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


  private
  def user_params
    params.require(:user).permit(:email,:password,:name,:birthday,:phone,:passport,:gender,:marriage,:address,:provined_id,:district_id,:ward_id)
  end

  private
  def drawdown_params
    params.require(:drawdown).permit(:sponsor_id, :contract_date, :media_contract_id, :contract_time, :position, :media_appoint_id, :appoint_in_contact, :salary, :media_salary_id, :amount, :amount_time, :purpose, :pay_time, :account_holders, :account_number, :bank_id, :branch_id, :user_id, :is_draft)
  end


end
