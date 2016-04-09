class AreasController < ApplicationController
  def show
    area_id = params['id']
    @area = Area.find(area_id)
    set_meta_tags title: "#{@area.name} 推薦醫院 科別 醫生",
                  description: "#就醫指南為您整理了 #{@area.name} 所有醫院，不同科別，醫生的完整資訊以及評價，讓您快速找到適合的醫生 ",
                  keywords: "#{@area.name},推薦醫院,推薦醫生,推薦醫師,就醫心得 "
    @areaHospitals = Hospital.where(area_id: area_id).paginate(:page => params[:page]).per_page(10)
    @areaGoodHospitals = Hospital.where(area_id: area_id).order(avg: :desc).limit(10)
    @areaPopHospitals = Hospital.where(area_id: area_id).order(avg: :desc).limit(10).offset(10)
    @areaGoodDoctors = Doctor.where(area_id: area_id).order(avg: :desc).limit(10)
    @areaPopDoctors = Doctor.where(area_id: area_id).order(avg: :desc).limit(10).offset(10)
    @areaDivisionComments = Comment.where.not(div_comment: nil).where.not(div_comment: "").paginate(:page => params[:page]).per_page(3)
    @areaDoctorComments = Comment.where.not(dr_comment: nil).where.not(dr_comment: "").paginate(:page => params[:page]).per_page(3)
  end
end
