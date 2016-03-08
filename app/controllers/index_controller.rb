class IndexController < ApplicationController
  def index
    @areas = Area.all
    @categories = Category.all
    @hospitals = Hospital.all
    @doctors = Doctor.all
    @comments = Comment.where.not(div_comment: (nil || "")).paginate(:page => params[:page])
  end
end
