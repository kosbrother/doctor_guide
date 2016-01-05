class Api::V1::CategoriesController < Api::ApiController

  def index
    categories = Category.select("id, name, intro").all
    render :json => categories
  end
end
