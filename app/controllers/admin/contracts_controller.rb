class Admin::ContractsController < ApplicationController
  layout 'layout_admin'
  def index
    @contracts = Contract.all
  end

  def edit
    @contract = Contract.find(params[:id])
  end

  def update
    @contract = Contract.find(params[:id])
    # binding.pry
    params_contract = params[:contract]
    status_contract = params_contract['status'].to_i
    if @contract.update(:status => status_contract)
      # insert history
      history = History.new(:contract_id => params[:id], :status_contract => status_contract, :summery => params_contract['value'], :orgin_rate => params_contract['orgin_rate'], :user_id => params_contract['user_id'])
      history.save

      # insert notifications
      notifi = Notification.new(:user_id => params_contract['user_id'], :title => "Thay doi trang thai Contract", :content => Contract.get_status(status_contract),:is_read => 0,:type => status_contract)
      notifi.save
      # binding.pry
      redirect_to admin_contracts_path, :flash => {:success => "Contract is updated"}
    else
      render 'edit'
    end
  end
  private
  def contract_params
    params.require(:contract).permit(:status)
  end
end
