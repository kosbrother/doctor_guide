class Api::V1::CategoriesController < Api::ApiController

  def index
    categories = Category.select("id, name").all
    render :json => categories
  end
end
