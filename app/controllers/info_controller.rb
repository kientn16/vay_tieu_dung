class InfoController < ApplicationController
  layout false , :only => ['show_drawdowns','show_status','show_pay']
  def index
    @contracts = Contract.paginate(:page => params[:page], :per_page => 10)
    @historys = History.where("user_id = #{params[:id]}")
    respond_to do |format|
      format.html
      format.csv { render text: @contracts.to_csv}
      format.xls { render text: @contracts.to_csv(col_sep: "\t")}
    end
  end

  def show_drawdowns
    @sponsors = Sponsor.all
    @banks = Bank.where('parent_id =?', 0)
    @drawdown = Drawdown.where('id = ? AND is_draft = ?', params[:id], 0).first
    # binding.pry
  end

  def show_status
    @status_contract = History.where('contract_id =?', params[:id]).order('created_at asc')
  end

  def show_pay
    @status_pay = History.where('contract_id =? AND status_contract =?', params[:id],88).order('created_at asc')
  end
end
