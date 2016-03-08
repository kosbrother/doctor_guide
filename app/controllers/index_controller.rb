class IndexController < ApplicationController
  def index
    @areas = Area.all
    @categories = Category.all
    @goodHospitals = Hospital.all.sort_by { |d| -d.recommend_num}.first(10)
    @goodDoctors = Doctor.all.sort_by { |d| -d.recommend_num}.first(10)
    @comments = Comment.where.not(div_comment: (nil || "")).paginate(:page => params[:page])
  end
end
