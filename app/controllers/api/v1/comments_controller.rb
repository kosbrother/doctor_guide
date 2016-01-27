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
end