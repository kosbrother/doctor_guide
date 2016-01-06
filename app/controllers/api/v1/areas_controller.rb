class Api::V1::AreasController < Api::ApiController

  def index
    areas = Area.select("id, name").all
    render :json => areas
  end
end
