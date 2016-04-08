class CommentsController < ApplicationController
  def show
    @comment = Comment.includes(:commentor, :hospital, :division, :doctor).find(params['id'])
    @hospital = @comment.hospital
    @division = @comment.division
    @doctor = @comment.doctor
    if params['doctor_id']
      @comments = Comment.includes(:commentor).where(doctor_id: @comment.doctor_id).where("id != #{@comment.id}").paginate(:page => params[:page]).per_page(3)
    else
      @comments = Comment.includes(:commentor).where(hospital_id: @comment.hospital_id, division_id: @comment.division_id).where("id != #{@comment.id}").paginate(:page => params[:page]).per_page(3)
    end
  end

  def new
    @hospital = Hospital.find(params['hospital_id'])
    @area = @hospital.area
    @comment = Comment.new(hospital_id: params['hospital_id'])
    if params['doctor_id']
      @doctor = Doctor.find(params['doctor_id'])
    end
    if params['division_id']
      @division = Division.find(params['division_id'])
    end
    unless @doctor
      if @division
        @doctorList = Doctor.joins(:divisions, :hospitals).where(divisions: {id: @division.id}, hospitals: {id: @hospital.id}).uniq{|x| x.id }.select('doctors.name, doctors.id')
      else
        @divisionList = Division.joins(:hospitals).where(hospitals: {id: @hospital.id}).uniq{|x| x.id}.select('divisions.id, divisions.name')
      end
    end
  end

  def update_doctor
    @doctorList = Doctor.joins(:divisions, :hospitals).where(divisions: {id: params['division_id']}, hospitals: {id: params['hospital_id']}).uniq{|x| x.id }.select('doctors.name, doctors.id').collect{|dr| [dr.name, dr.id]}
    render json: @doctorList
  end


  def create
    @hospital = Hospital.find(params['hospital_id'])
    @comment = Comment.new(comment_params)
    @comment.save
    if params['doctor_id']
      @doctor = Doctor.find(params['doctor_id'])
      @division = Division.find(params['division_id'])
      redirect_to hospital_division_doctor_comment_path(@hospital, @division, @doctor,  @comment)
    elsif params['division_id']
      @division = Division.find(params['division_id'])
      redirect_to hospital_division_comment_path(@hospital, @division, @comment)
    else
      redirect_to hospital_path(@hospital)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:hospital_id, :division_id, :doctor_id, :div_equipment, :div_environment,
                                    :div_speciality, :div_friendly, :div_comment, :dr_speciality, :dr_friendly,
                                    :is_recommend, :dr_comment, :user_id)
  end
end
