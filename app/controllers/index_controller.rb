class IndexController < ApplicationController
  def index
    @areas = Area.all
    @categories = Category.all
    @goodHospitals = Hospital.order(avg: :desc).limit(10)
    @popHospitals = Hospital.order(avg: :desc).limit(10).offset(10)
    @goodDoctors = Doctor.order(avg: :desc).limit(10)
    @popHospitals = Doctor.order(avg: :desc).limit(10).offset(10)
    @doctorComments = Comment.where.not(dr_comment: nil).where.not(dr_comment: "").paginate(:page => params[:page])
    @divisionComments = Comment.where.not(div_comment: nil).where.not(div_comment: "").paginate(:page => params[:page])
  end
end
