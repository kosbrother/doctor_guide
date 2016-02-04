class Api::V1::ProblemsController < Api::ApiController

  def create
    problem = Problem.new
    problem.doctor_id = params[:doctor_id]
    problem.hospital_id = params[:hospital_id]
    problem.division_id = params[:division_id]
    problem.content = params[:content]

    if problem.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end
end
