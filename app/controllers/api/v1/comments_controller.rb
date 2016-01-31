class Api::V1::CommentsController < Api::ApiController
  def index
    if params[:hospital_id] && params[:division_id]
      comments = Comment.where(hospital_id: params[:hospital_id],division_id: params[:division_id]).select_comment
    elsif params[:hospital_id]
      comments = Comment.where(hospital_id: params[:hospital_id]).select_comment
    elsif params[:doctor_id]
      comments = Comment.where(doctor_id: params[:doctor_id]).select_comment
    end

    render :json => comments
  end

  def show
    comment = Comment.select_comment.find(params[:id])
    render :json => comment
  end

  def create
    user = User.find_by(email: params[:user])

    if user.present?
      comment = user.comments.new
      set_comment_params comment,params

      if comment.save
        render :status=>200, :json => {"message" => "create comment success"}
      else
        render :status=>404, :json => {"message" => "create comment fail"}
      end
    else
      render :status=>404, :json => {"message" => "not find user"}
    end
  end

  def update
    comment = Comment.find(params[:id])
    if comment.present?
      set_comment_params comment,params
      if comment.save
        render :status=>200, :json => {"message" => "update comment success"}
      else
        render :status=>404, :json => {"message" => "update comment fail"}
      end
    else
      render :status=>404, :json => {"message" => "not find comment"}
    end
  end

  def user_comments
    user = User.find_by(email: params[:user])
    comments = user.comments.includes(:doctor,:hospital,:division,:commentor).select('
        comments.id,dr_friendly,dr_speciality,div_equipment,div_environment,div_speciality,div_friendly,doctor_id,hospital_id,division_id,div_comment,dr_comment,is_recommend,user_id,updated_at')
    comments_json = []
    comments.each do |comment|
      c_hash = comment.attributes
      (comment.commentor) ? c_hash[:user_name] = comment.commentor.name : c_hash[:user_name] = nil
      (comment.hospital) ? c_hash[:hospital_name] = comment.hospital.name : c_hash[:hospital_name] = nil
      (comment.division) ? c_hash[:division_name] = comment.division.name : c_hash[:division_name] = nil
      (comment.doctor) ? c_hash[:doctor_name] = comment.doctor.name : c_hash[:doctor_name] = nil
      comments_json.push(c_hash)
    end
    render :json => comments_json
  end

  private

  def set_comment_params comment,params
    comment.dr_speciality = params[:dr_speciality]
    comment.dr_friendly = params[:dr_friendly]
    comment.div_equipment = params[:div_equipment]
    comment.div_environment = params[:div_environment]
    comment.div_speciality = params[:div_speciality]
    comment.div_friendly = params[:div_friendly]
    comment.doctor_id = params[:doctor_id]
    comment.hospital_id = params[:hospital_id]
    comment.division_id = params[:division_id]
    comment.div_comment = params[:div_comment]
    comment.dr_comment = params[:dr_comment]
    comment.is_recommend = params[:is_recommend]
  end
end