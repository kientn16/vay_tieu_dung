class Admin::DrawdownsController < ApplicationController
  layout 'layout_admin'
  def index
    @drawdowns = Drawdown.paginate(:page => params[:page], :per_page => 10)
  end

  def edit

  end

  def update

  end

  def show
    @drawdown = Drawdown.find(params[:id])
  end

  def accept_drawdowns
    drawdowns_id = params[:drawdowns_id]
    # update status contract
    contract = Contract.find_by_drawdowns_id(drawdowns_id)
    contract.status = 0
    contract.save

    # insert history
    history = History.new(:contract_id => contract.id, :status_contract => 0, :summery => contract.value, :orgin_rate => contract.value)
    history.save

    # insert notifications
    notifi = Notification.new(:user_id => contract.user_id, :title => "Thong bao duyet ho so vay", :content => "Chung toi da chap nhan ho so cua ban",:is_read => 0,:type => 0)
    notifi.save

    user = User.find(contract.user_id)

    NotifiMailer.notifi_email(user,0).deliver_now

    render json: contract
  end

  def un_accept_drawdowns
    drawdowns_id = params[:drawdowns_id]
    # update status contract
    contract = Contract.find_by_drawdowns_id(drawdowns_id)
    contract.status = 2
    contract.save

    # insert history
    history = History.new(:contract_id => contract.id, :status_contract => 2, :summery => contract.value, :orgin_rate => contract.value)
    history.save

    # insert notifications
    notifi = Notification.new(:user_id => contract.user_id, :title => "Thong bao duyet ho so vay", :content => "Chung toi khong chap nhan ho so cua ban",:is_read => 0,:type => 2)
    notifi.save

    user = User.find(contract.user_id)

    NotifiMailer.notifi_email(user,2).deliver_now
    render json: contract
  end
end
