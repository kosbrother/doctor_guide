class Api::V1::AreasController < Api::ApiController

  def index
    areas = Area.select("id, name, latitude, longitude").all
    render :json => areas
  end
end
