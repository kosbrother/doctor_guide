class CategoriesController < ApplicationController
  def show
    if params['area_id']
      @area = Area.find(params['area_id'])
    end
    @category = Category.find(params['id'])
    @areaCateHospitals = @category.hospitals.where(area_id: params['area_id']).uniq{|x| x.id}.paginate(:page => params[:page]).per_page(10)
    @areaCateGoodHospitals =  @areaCateHospitals.order('recommend_num desc').limit(10)
    @areaCatePopHospitals = @areaCateHospitals.order('comment_num desc').limit(10)
    @areaCateDoctors =  Doctor.joins(:divisions, :div_hosp_doc_ships).where('divisions.category_id = 4 AND doctors.area_id = 4').uniq{|x| x.id}
    @areaCateGoodDoctors = @areaCateDoctors.order('recommend_num desc').limit(10)
    @areaCatePopDoctors = @areaCateDoctors.order('comment_num desc').limit(10)

  end
end
