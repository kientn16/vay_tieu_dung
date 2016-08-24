class Admin::DrawdownsController < ApplicationController
  layout 'layout_admin'
  def index
    @drawdowns = Drawdown.paginate(:page => params[:page], :per_page => 10)
  end

  def edit

  end

  def update

  end
end
