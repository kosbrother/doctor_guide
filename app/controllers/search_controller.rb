class SearchController < ApplicationController

  def search

  end

  def byArea
    @categories = Category.all
    @hospitals = Hospital.where(area_id: 4).paginate(:page => params[:page])
    @goodDoctors = Doctor.all.sort_by { |d| -d.recommend_num}.first(10)
    @goodHospitals = Hospital.all.sort_by { |d| -d.recommend_num}.first(10)
    @comments = Comment.where.not(div_comment: (nil || "")).paginate(:page => params[:page])
  end

  def byCategory
    @areas = Area.all
    @hospitals = Hospital.where(area_id: 4).first(40)
    @goodDoctors = Doctor.all.sort_by { |d| -d.recommend_num}.first(10)
    @goodHospitals = Hospital.all.sort_by { |d| -d.recommend_num}.first(10)
    @comments = Comment.where.not(div_comment: (nil || "")).paginate(:page => params[:page])
  end

  def byAreaCategory
    @categories = Category.all
    @hospitals = Hospital.where(area_id: 4).paginate(:page => params[:page])
    @goodDoctors = Doctor.all.sort_by { |d| -d.recommend_num}.first(10)
    @goodHospitals = Hospital.all.sort_by { |d| -d.recommend_num}.first(10)
    @comments = Comment.where.not(div_comment: (nil || "")).paginate(:page => params[:page])
  end
end
