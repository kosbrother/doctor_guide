class IndexController < ApplicationController
  def index
    @goodHospitals = Hospital.order(recommend_num: :desc).limit(10)
    @popHospitals = Hospital.order(comment_num: :desc).limit(10)
    @goodDoctors = Doctor.includes(:hospitals, :divisions).order('doctors.recommend_num desc').limit(10)
    @popDoctors =  Doctor.includes(:hospitals, :divisions).order('doctors.comment_num desc').limit(10)
    @doctorComments = Comment.includes(:commentor, :doctor, :hospital, :division).where.not(dr_comment: nil).where.not(dr_comment: '').paginate(:page => params[:page]).per_page(3)
    @divisionComments = Comment.includes(:commentor, :doctor, :hospital, :division).where.not(div_comment: nil).where.not(div_comment: '').paginate(:page => params[:page]).per_page(3)
  end
end
