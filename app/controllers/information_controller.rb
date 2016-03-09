class InformationController < ApplicationController
  def hospital
    @categories = Category.all
    @hospitals = Hospital.where(area_id: 4).paginate(:page => params[:page])
    @goodDoctors = Doctor.all.sort_by { |d| -d.recommend_num}.first(10)
    @goodCategories =  Category.all.first(10)
    @comments = Comment.where.not(div_comment: (nil || "")).paginate(:page => params[:page])
  end

  def category
  end

  def doctor
  end
end
