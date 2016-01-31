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