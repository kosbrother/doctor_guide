class DivisionsController < ApplicationController
  def show
    @hospital = Hospital.find(params['hospital_id'])
    @division = @hospital.divisions.find(params['id'])

    @otherDivisions = @hospital.divisions.where("div_hosp_doc_ships.doctor_id is not null and divisions.id != #{params['id']}").uniq{|x| x.id}
    if @otherDivisions.size == 0
      @otherDivisions = @hospital.divisions.where.not(id: params['id']).uniq{|x| x.id}
    end

    @comments = Comment.where(hospital_id: params['hospital_id'], division_id: params['id'])
    @recommendNum = @comments.where(is_recommend: true).count
    @commentNum = @comments.where.not(div_comment: (nil || "")).count
    @divEquipment =  @comments.average(:div_equipment).to_f.round(1)
    @divEnvironment = @comments.average(:div_environment).to_f.round(1)
    @divSpeciality = @comments.average(:div_speciality).to_f.round(1)
    @divFriendly = @comments.average(:div_friendly).to_f.round(1)
    @avgRate = ( @divEquipment + @divEnvironment + @divSpeciality + @divFriendly) / 4
    @drFriendly = @comments.average(:dr_friendly).to_f.round(1)
    @drSpeciality = @comments.average(:dr_speciality).to_f.round(1)
    @avgDocRate = (@drFriendly + @drSpeciality) / 2
    @doctors =  DivHospDocShip.where(hospital_id: params['hospital_id'], division_id: params['id']).where.not(doctor_id: 'NULL').map{|list| list.doctor}
    @commentsPage =  @comments.where.not(div_comment: (nil || "")).paginate(:page => params[:page]).per_page(3)
  end
end
