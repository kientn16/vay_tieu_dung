class DrawdownsController < ApplicationController
  before_action :authenticate_user!
	def index
    @numberNotification = Notification.get_notifications(0, current_user.id).count
    @user = User.find(current_user.id)
    if @user.media_id.nil? || @user.media_id == 0
      flash[:error] = 'Mời bạn Upload CMT/Hộ chiếu ở Tab Tài khoản trước khi sử dụng chức năng Đề nghị vay'
      redirect_to users_path
    else
      @amount = params[:amount]
      @amountTime = params[:amount_time]
      @sponsors = Sponsor.all
      @banks = Bank.where('parent_id =?', 0)
      @drawdown = Drawdown.where('user_id = ? AND is_draft = ?', current_user.id, 1).first
      if @drawdown.nil?
        @drawdown = Drawdown.new
      end
    end
  end
  
  def create
    params[:drawdown][:appoint_in_contact] = params[:drawdown][:appoint_in_contact] != nil ? params[:drawdown][:appoint_in_contact] : 0
    params[:drawdown][:contract_time] = params['day']+"/"+params['month']+"/"+params['year']
    flag = Drawdown.proccess_drawdown(nil, drawdown_params, params, current_user.id)
    if flag != false
      flash[:success] = 'De nghi vay da duoc gui di. Chung toi se duyet de nghi cua ban trong thoi gian som nhat'
      redirect_to drawdowns_path()
    else
      flash[:error] = 'Error'
    end
  end

  def update
    params[:drawdown][:appoint_in_contact] = params[:drawdown][:appoint_in_contact] != nil ? params[:drawdown][:appoint_in_contact] : 0
    params[:drawdown][:contract_time] = params['day']+"/"+params['month']+"/"+params['year']
    @drawdown = Drawdown.find(params[:id])
    if !@drawdown.nil?
      flag = Drawdown.proccess_drawdown(@drawdown, drawdown_params, params, current_user.id)
      if flag != false
        flash[:success] = 'De nghi vay da duoc gui di. Chung toi se duyet de nghi cua ban trong thoi gian som nhat'
        redirect_to drawdowns_path()
      else
        flash[:error] = 'Error'
        @sponsors = Sponsor.all
        @banks = Bank.where('parent_id =?', 0)
        render :index
      end
    else
      flash[:error] = 'Not found drawdown'
      redirect_to drawdowns_path()
    end
  end


  

  private
  def drawdown_params
    params.require(:drawdown).permit(:sponsor_id, :contract_date, :media_contract_id, :contract_time, :position, :media_appoint_id, :appoint_in_contact, :salary, :media_salary_id, :amount, :amount_time, :purpose, :pay_time, :account_holders, :account_number, :bank_id, :branch_id, :user_id, :is_draft)
  end
end
