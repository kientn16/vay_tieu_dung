class InfoController < ApplicationController
  def index
    @contracts = Contract.paginate(:page => params[:page], :per_page => 10)
    @historys = History.where("user_id = #{params[:id]}")
  end
end
