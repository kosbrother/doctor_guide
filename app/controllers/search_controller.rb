class SearchController < ApplicationController

  def search

  end

  def byArea
    area_id = params['area']
    @area = Area.find(area_id)
    @areaHospitals = Hospital.where(area_id: area_id).paginate(:page => params[:page]).per_page(10)
    @areaGoodHospitals = Hospital.where(area_id: area_id).order(avg: :desc).limit(10)
    @areaPopHospitals = Hospital.where(area_id: area_id).order(avg: :desc).limit(10).offset(10)
    @areaGoodDoctors = Doctor.where(area_id: area_id).order(avg: :desc).limit(10)
    @areaPopDoctors = Doctor.where(area_id: area_id).order(avg: :desc).limit(10).offset(10)
    @areaDivisionComments = Comment.where.not(div_comment: nil).where.not(div_comment: "").paginate(:page => params[:page]).per_page(3)
    @areaDoctorComments = Comment.where.not(dr_comment: nil).where.not(dr_comment: "").paginate(:page => params[:page]).per_page(3)
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
