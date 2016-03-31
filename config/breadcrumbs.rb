# root crumb
crumb :root do
  link "首頁", root_path
end

crumb :searchResult do
  link '搜尋結果', search_path
end

# search crumb
crumb :area do |area|
  link area.name, area_path(area)
end

crumb :category do |category|
  link category.name, category_path(category)
end

crumb :areaCategory do |category, area|
  link category.name, category_path(category)
  parent :area, area
end

# information crumb
crumb :hospital do |hospital, area|
  link hospital.name, hospital_path(hospital)
  if area
    parent :area, area
  else
    parent :area, hospital.area
  end
end

crumb :division do |division, hospital, area|
  link division.name, hospital_division_path(hospital, division)
  if area
    parent :hospital, hospital, area
  else
    parent :hospital, hospital, hospital.area
  end
end

crumb :doctor do |doctor, division, hospital, area|
  link doctor.name, hospital_division_doctor_path(hospital, division, doctor)
  parent :division, division, hospital, area
end

# comment crumb
crumb :doctorComment do |comment, doctor, division, hospital|
  link '醫師評論詳情', hospital_division_doctor_comment_path(comment, doctor, division, hospital)
  parent :doctor, doctor, division, hospital
end

crumb :divisionComment do |comment, division, hospital|
  link '科別評論詳情', hospital_division_comment_path(comment, division, hospital)
  parent :division, division, hospital
end

# recommend more
crumb :recommendDoctors do
  link '推薦醫師', doctors_recommend_path
end

crumb :popularDoctors do
  link '熱門醫師', doctors_popular_path
end

crumb :recommendHospitals do
  link '推薦醫院', hospitals_recommend_path
end

crumb :popularHospitals do
  link '熱門醫院', hospitals_popular_path
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).