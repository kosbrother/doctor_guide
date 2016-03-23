class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :loadAsideData
  def loadAsideData
    @areas = Area.all
    @categories = Category.all
  end

  def not_found
    render :file => 'public/404.html', :status => :not_found
  end
end
