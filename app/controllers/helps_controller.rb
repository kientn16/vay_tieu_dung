class HelpsController < ApplicationController
  def index
    @faqs = Content.where("type = 2").paginate(:page => params[:page], :per_page => 5)
    @articles = Content.where("type = 1").paginate(:page => params[:page], :per_page => 2)
  end
end
