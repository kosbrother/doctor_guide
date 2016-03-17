class InformationController < ApplicationController
  def hospital
    hospital_id = params['hospital']
    @hospital = Hospital.find(hospital_id)
    @area = Area.find(@hospital.area)
    @areas = Area.all
    @categories = Category.all
    @categories = Category.all
    @hospitals = Hospital.where(area_id: 4).paginate(:page => params[:page])
    @goodDoctors = Doctor.all.sort_by { |d| -d.recommend_num}.first(10)
    @goodCategories =  Category.all.first(10)
    @comments = Comment.where.not(div_comment: (nil || "")).paginate(:page => params[:page])
  end

  def category
    @categories = Category.all
  end

  def doctor

  end
end
