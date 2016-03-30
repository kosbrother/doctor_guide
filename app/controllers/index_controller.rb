class IndexController < ApplicationController
  def index
    @goodHospitals = Hospital.order(recommend_num: :desc).limit(10)
    @popHospitals = Hospital.order(comment_num: :desc).limit(10)
    doctors = DivHospDocShip.includes(:hospital, :division, :doctor).where.not('divisions.id': nil, 'hospital_id': nil)
    @goodDoctors = doctors.order('doctors.recommend_num desc').limit(10)
    @popDoctors = doctors.order('doctors.comment_num desc').limit(10)
    @doctorComments = Comment.includes(:commentor, :doctor, :hospital, :division).where.not(dr_comment: (nil || '')).paginate(:page => params[:page]).per_page(3)
    @divisionComments = Comment.includes(:commentor, :doctor, :hospital, :division).where.not(div_comment: (nil || '')).paginate(:page => params[:page]).per_page(3)
  end
end
