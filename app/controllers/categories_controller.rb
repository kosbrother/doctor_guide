class CategoriesController < ApplicationController
  def show
    if params['area_id']
      @area = Area.find(params['area_id'])
    end
    @category = Category.find(params['id'])
    @areaCateHospitals = @category.hospitals.where(area_id: params['area_id']).paginate(:page => params[:page]).per_page(10)

  end
end
