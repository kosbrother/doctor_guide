class Api::V1::UsersController < Api::ApiController
  def create
    user = User.find_or_initialize_by(email: params[:email])
    user.name = params[:name]
    user.pic_url = params[:pic_url]
    user.app_id = params[:app_id]

    if user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end
end