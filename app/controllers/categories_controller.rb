class CategoriesController < ApplicationController
  def show
    @category = Category.find(params['id'])
    set_meta_tags title: @category.name + '推薦醫院 醫生'

    if params['area_id']
      @area = Area.find(params['area_id'])
      @areaName = @area.name
      @areaCateHospitals = @category.hospitals.where(area_id: @area.id).uniq{|x| x.id}.paginate(:page => params[:page]).per_page(10)
      @areaCateGoodHospitals =  @areaCateHospitals.order('recommend_num desc').limit(10)
      @areaCatePopHospitals = @areaCateHospitals.order('comment_num desc').limit(10)
      areaCateDoctors =  Doctor.joins(:divisions, :div_hosp_doc_ships).where("divisions.category_id = #{@category.id} AND doctors.area_id = #{@area.id}").uniq{|x| x.id}
      areaCateComments = Comment.where("(comments.`hospital_id`,
                                         comments.`division_id`)
                                        IN ( SELECT divisions.id, hospitals.id FROM hospitals
                                        INNER JOIN `div_hosp_doc_ships` ships
                                        ON hospitals.id = ships.hospital_id
                                        INNER JOIN divisions
                                        ON ships.`division_id` = divisions.id
                                        WHERE hospitals.`area_id` = #{@area.id} AND
                                        divisions.`category_id` = #{@category.id})")
    else
      @area = Area.find(params['choose_area_id'])
      @areaName = ''
      @areaCateHospitals = @category.hospitals.where(area_id: @area.id).uniq{|x| x.id}.paginate(:page => params[:page]).per_page(10)
      cateHospitals = @category.hospitals.select('DISTINCT hospitals.*')
      @areaCateGoodHospitals = cateHospitals.order('recommend_num desc').limit(10)
      @areaCatePopHospitals = cateHospitals.order('comment_num desc').limit(10)
      areaCateDoctors =  Doctor.joins(:divisions, :div_hosp_doc_ships).where("divisions.category_id = #{@category.id}").uniq{|x| x.id}
      areaCateComments = Comment.where(" (comments.`division_id`)
                                        IN ( SELECT divisions.id FROM divisions
                                        WHERE divisions.`category_id` = #{@category.id})")
    end

    @areaCateGoodDoctors = areaCateDoctors.order('recommend_num desc').limit(10)
    @areaCatePopDoctors = areaCateDoctors.order('comment_num desc').limit(10)

    @areaCateDivisionComments = areaCateComments.where.not(div_comment: nil).where.not(div_comment: "").paginate(:page => params[:page]).per_page(3)
    @areaCateDoctorComments = areaCateComments.where.not(dr_comment: nil).where.not(dr_comment: "").paginate(:page => params[:page]).per_page(3)
  end
end
