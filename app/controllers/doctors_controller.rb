class DoctorsController < ApplicationController
  def index
  end

  def show
      @doctor = Doctor.friendly.find(params['id'])
      @hospital =  Hospital.friendly.find(params['hospital_id'])
      @division = Division.find(params['division_id'])
      @category = @division.category
      @record =  Comment.select('AVG(`comments`.`dr_friendly`) AS avg_friendly, AVG(`comments`.`dr_speciality`) AS avg_speciality, COUNT(*) AS count').where(doctor_id: params['id'])
      @comments = Comment.includes(:division).joins(:commentor).select('comments.*, users.name AS user_name').where(doctor_id: params['id']).paginate(:page => params[:page], total_entries: @record[0].count).per_page(3)
      @area = @doctor.area
      set_meta_tags title: "#{@hospital.name} - #{@division.name} - #{@doctor.name}",
                    description: "#{@area.name} #{@hospital.name} #{@division.name} #{@doctor.name} 醫師的門診資訊，網友就醫經驗分享與醫師評價",
                    keywords: "#{@hospital.name},#{@division.name},#{@doctor.name},醫師資訊,評價,就醫心得"
      @goodDoctors = Doctor.joins(:divisions).includes(:hospitals).where(area_id: @area.id, divisions: {id: @division.id}).order('doctors.recommend_num desc').limit(10)
      @popDoctors = Doctor.joins(:divisions).includes(:hospitals).where(area_id: @area.id, divisions: {id: @division.id}).order('doctors.comment_num desc').limit(10)
  end

  def recommend
    set_meta_tags title: '推薦醫師',
                  description: '就醫指南推薦醫師列表',
                  keyword: '推薦醫師'
    @doctors = Doctor.order('recommend_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
  end

  def popular
    set_meta_tags title: '熱門醫師',
                  description: '就醫指南熱門醫師列表',
                  keyword: '熱門醫師'
    @doctors = Doctor.order('comment_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
  end

  def area_recommend
    @area = Area.find(params['id'])
    set_meta_tags title:  "#{@area.name} 推薦醫師",
                  description: "#{@area.name} 推薦醫師列表",
                  keyword: "#{@area.name},推薦醫師"
    @doctors = Doctor.where(area_id: params['id']).order('recommend_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
  end

  def area_popular
    @area = Area.find(params['id'])
    set_meta_tags title:  "#{@area.name} 熱門醫師",
                  description: "#{@area.name} 熱門醫師列表",
                  keyword: "#{@area.name},熱門醫師"
    @doctors = Doctor.where(area_id: params['id']).order('comment_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
  end

  def area_categories_recommend
    @doctors = Doctor.joins('INNER JOIN div_hosp_doc_ships ON doctors.id = div_hosp_doc_ships.`doctor_id` INNER JOIN divisions ON divisions.id = div_hosp_doc_ships.`division_id` INNER JOIN categories ON categories.id = divisions.category_id INNER JOIN hospitals ON hospitals.id = div_hosp_doc_ships.hospital_id')
                   .where("categories.id = #{params['id']} AND hospitals.area_id = #{params['area_id']}").order('doctors.recommend_num desc').limit(100).paginate(page: params['page']).per_page(20)
    @category = Category.find(params['id'])
    @area = Area.find(params['area_id'])
    set_meta_tags title:  "#{@area.name}  #{@category.name} 推薦醫師",
                  description: "#{@area.name}#{@category.name} 推薦醫師列表",
                  keyword: "#{@area.name},#{@category.name},推薦醫師"
  end

  def area_categories_popular
    @doctors = Doctor.joins('INNER JOIN div_hosp_doc_ships ON doctors.id = div_hosp_doc_ships.`doctor_id` INNER JOIN divisions ON divisions.id = div_hosp_doc_ships.`division_id` INNER JOIN categories ON categories.id = divisions.category_id INNER JOIN hospitals ON hospitals.id = div_hosp_doc_ships.hospital_id')
                  .where("categories.id = #{params['id']} AND hospitals.area_id = #{params['area_id']}").order('doctors.recommend_num desc').limit(100).paginate(page: params['page']).per_page(20)
    @category = Category.find(params['id'])
    @area = Area.find(params['area_id'])
    set_meta_tags title:  "#{@area.name} #{@category.name} 熱門醫師",
                  description: "#{@area.name}#{@category.name} 熱門醫師列表",
                  keyword: "#{@area.name},#{@category.name},熱門醫師"
  end

  def categories_recommend
    @doctors = Doctor.joins('INNER JOIN div_hosp_doc_ships ON doctors.id = div_hosp_doc_ships.`doctor_id` INNER JOIN divisions ON divisions.id = div_hosp_doc_ships.`division_id` INNER JOIN categories ON categories.id = divisions.category_id')
                  .where("categories.id = #{params['id']}").order('doctors.recommend_num desc').limit(100).paginate(page: params['page']).per_page(20)
    @category = Category.find(params['id'])
    set_meta_tags title:  "#{@category.name} 推薦醫師",
                  description: "＝#{@category.name} 推薦醫師列表",
                  keyword: "#{@category.name},推薦醫師"
  end

  def categories_popular
    @doctors = Doctor.joins('INNER JOIN div_hosp_doc_ships ON doctors.id = div_hosp_doc_ships.`doctor_id` INNER JOIN divisions ON divisions.id = div_hosp_doc_ships.`division_id` INNER JOIN categories ON categories.id = divisions.category_id')
                   .where("categories.id = #{params['id']}").order('doctors.comment_num desc').limit(100).paginate(page: params['page']).per_page(20)
    @category = Category.find(params['id'])
    set_meta_tags title:  "#{@category.name} 熱門醫師",
                  description: "#{@category.name} 熱門醫師列表",
                  keyword: "#{@category.name},熱門醫師"

  end

  def hospital_recommend
    @doctors = Doctor.joins('INNER JOIN div_hosp_doc_ships ON doctors.id = div_hosp_doc_ships.`doctor_id`').where("div_hosp_doc_ships.hospital_id = #{params['id']}").order('recommend_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
    @hospital = Hospital.find(params['id'])
    set_meta_tags title:  "#{@hospital.name} 推薦醫師",
                  description: "#{@hospital.name} 推薦醫師列表",
                  keyword: "#{@hospital.name},推薦醫師"
  end

  def hospital_popular
    @doctors = Doctorjoins('INNER JOIN div_hosp_doc_ships ON doctors.id = div_hosp_doc_ships.`doctor_id`').where("div_hosp_doc_ships.hospital_id = #{params['id']}").order('comment_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
    set_meta_tags title:  "#{@hospital.name} 熱門醫師",
                  description: "#{@hospital.name} 熱門醫師列表",
                  keyword: "#{@hospital.name},熱門醫師"
  end
end
