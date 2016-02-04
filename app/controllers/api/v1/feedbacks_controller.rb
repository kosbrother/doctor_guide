class Api::V1::FeedbacksController < Api::ApiController
  def create
    feedback = Feedback.new
    feedback.subject = params[:subject]
    feedback.content = params[:content]

    if feedback.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end
end
