class AreasController < ApplicationController
  def show
    area_id = params['id']
    @area = Area.find(area_id)
    set_meta_tags title: @area.name + '推薦醫院 科別 醫生'
    @areaHospitals = Hospital.where(area_id: area_id).paginate(:page => params[:page]).per_page(10)
    @areaGoodHospitals = Hospital.where(area_id: area_id).order(avg: :desc).limit(10)
    @areaPopHospitals = Hospital.where(area_id: area_id).order(avg: :desc).limit(10).offset(10)
    @areaGoodDoctors = Doctor.where(area_id: area_id).order(avg: :desc).limit(10)
    @areaPopDoctors = Doctor.where(area_id: area_id).order(avg: :desc).limit(10).offset(10)
    @areaDivisionComments = Comment.where.not(div_comment: nil).where.not(div_comment: "").paginate(:page => params[:page]).per_page(3)
    @areaDoctorComments = Comment.where.not(dr_comment: nil).where.not(dr_comment: "").paginate(:page => params[:page]).per_page(3)
  end
end
