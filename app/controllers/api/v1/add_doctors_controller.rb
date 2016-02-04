class Api::V1::AddDoctorsController < Api::ApiController

  def create
    doctor = AddDoctor.new
    doctor.name = params[:name]
    doctor.hospital_name = params[:hospital_name]
    doctor.division_name = params[:division_name]
    doctor.spe = params[:spe]
    doctor.exp = params[:exp]
    doctor.hospital_id = params[:hospital_id]
    doctor.division_id = params[:division_id]

    if doctor.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end
end
