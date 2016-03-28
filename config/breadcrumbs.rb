# root crumb
crumb :root do
  link "首頁", root_path
end

crumb :searchResult do
  link '搜尋結果', search_path
end

# search crumb
crumb :area do |area|
  link area.name, area_path(area.id)
end

crumb :category do |category|
  link category.name, category_path(category.id)
end

crumb :areaCategory do |category, area|
  link category.name, category_path(category.id)
  parent :area, area
end

# information crumb
crumb :hospital do |hospital|
  link hospital.name, hospital_path(hospital.id)
  parent :area, hospital.area
end

crumb :division do |division, hospital|
  link division.name, hospital_division_path(hospital.id, division.id)
  parent :hospital, hospital
end

crumb :doctor do |doctor, division, hospital|
  link doctor.name, hospital_division_doctor_path(hospital.id, division.id, doctor.id)
  parent :division, division, hospital
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
crumb :recommendDoctor do
  link '推薦醫生', doctors_recommend_path
end

crumb :recommendHospital do
  link '推薦醫院', hospitals_recommend_path
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