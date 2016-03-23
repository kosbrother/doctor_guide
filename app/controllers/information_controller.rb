class InformationController < ApplicationController

  def division

  end


  def doctorId
    @doctor = Doctor.find(params['doctor'])
    @hospital = @doctor.hospitals[0]
    params['hospital'] = @hospital.id
    @division = @doctor.divisions.where("div_hosp_doc_ships.doctor_id = #{@doctor.id} AND div_hosp_doc_ships.hospital_id = #{params['hospital']}" )[0]
    params['division'] = @hospital.id

    redirect_to doctor_path(@hospital.id, @division.id,@doctor.id )
  end
end
