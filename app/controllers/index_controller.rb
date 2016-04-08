class IndexController < ApplicationController
  def index
    set_meta_tags description: '推薦台灣好醫師，好醫院，提供全台醫院，門診，診所，就醫心得與評價，讓每個人都可以將自己的就醫經驗分享，推薦醫生'
    @goodHospitals = Hospital.order(recommend_num: :desc).limit(10)
    @popHospitals = Hospital.order(comment_num: :desc).limit(10)
    @goodDoctors = Doctor.includes(:hospitals, :divisions).order('doctors.recommend_num desc').limit(10)
    @popDoctors =  Doctor.includes(:hospitals, :divisions).order('doctors.comment_num desc').limit(10)
    @doctorComments = Comment.includes(:commentor, :doctor, :hospital, :division).where.not(dr_comment: nil).where.not(dr_comment: '').paginate(:page => params[:page]).per_page(3)
    @divisionComments = Comment.includes(:commentor, :doctor, :hospital, :division).where.not(div_comment: nil).where.not(div_comment: '').paginate(:page => params[:page]).per_page(3)
  end
end
