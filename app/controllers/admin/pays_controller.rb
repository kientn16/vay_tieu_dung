class Admin::PaysController < ApplicationController
  layout 'layout_admin'

  def index
    @pays = History.new
  end

  def new
    @pays = History.new
  end

  def create
    # binding.pry
    @dataContract = Contract.find(params[:contract_id])
    @origin_rate = params[:origin_rate].to_i
    # binding.pry
    if @dataContract.debt > @origin_rate
      @pays = History.new(:contract_id =>params[:contract_id],:status_contract => 88,:orgin_rate => @origin_rate,:user_id => @dataContract.user_id)
    else
      @pays = History.new(:contract_id => params[:contract_id],:status_contract => 88,:orgin_rate => @dataContract.debt,:user_id => @dataContract.user_id).save
    end
    @pays.save
    # binding.pry
    @dataContract.paid = @dataContract.paid + @origin_rate
    @dataContract.debt = @dataContract.value.to_i - @dataContract.paid
    @dataContract.save

    redirect_to admin_contracts_path, :flash => {:success => "Pays Successfully for #{@dataContract.code}"}
  end

end
