class CommentsController < ApplicationController
  def show
    @comment = Comment.find(params['id'])
    if params['doctor_id']
      @doctor = Doctor.find(params['doctor_id'])
      @comments = Comment.where(doctor_id: @comment.doctor_id).where("id != #{@comment.id}").paginate(:page => params[:page]).per_page(3)

    else
      @comments = Comment.where(hospital_id: @comment.hospital_id, division_id: @comment.division_id).where("id != #{@comment.id}").paginate(:page => params[:page]).per_page(3)
    end
    @hospital = Hospital.find(params['hospital_id'])
    @division = Division.find(params['division_id'])

  end

  def new
    @hospital = Hospital.find(params['hospital_id'])
    @area = @hospital.area
    if params['division_id']
      @division = Division.find(params['division_id'])
    end
    if params['doctor_id']
      @doctor = Doctor.find(params['doctor_id'])
    end
  end
end
