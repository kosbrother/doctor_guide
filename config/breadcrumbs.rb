# root crumb
crumb :root do
  link "首頁", root_path
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