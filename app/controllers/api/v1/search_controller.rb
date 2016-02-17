class Api::V1::SearchController < Api::ApiController
  def search_doctors
    if params[:q].nil?
      doctors = []
    else
      doctors = Doctor.search params[:q]
    end
    render :json => doctors
  end
  def search_hospitals
    if params[:q].nil?
      hospitals = []
    else
      hospitals = Hospital.search params[:q]
    end
    render :json => hospitals
  end  
end
