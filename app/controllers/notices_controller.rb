class NoticesController < ApplicationController
  has_mobile_fu
  before_filter :all_category, :only => [:index,:list]

  def index
    @notices = Notice.order("id desc").page(params[:page]).per(15)
  end

  def show
    @notice = Notice.find_by_number(params[:id])
  end

  def list
    @category=NoticesCategory.find(params[:id])
    @notices=@category.notices.order("id desc").page(params[:page]).per(15)
    render :action => :index
  end

  protected
  def all_category
    @notices_category=NoticesCategory.all
  end
end
