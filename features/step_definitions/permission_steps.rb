Given /^"([^"]*)" can ([^"]*?) ([o|i]n)?\s?the "([^"]*)" project$/ do |email, action, on, project_name|
  create_permission(email, find_project(project_name), action)
end

def create_permission(email, object, action)
  Permission.create!(:user => User.find_by_email!(email),
                     :thing => object,
                     :action => action)
end

def find_project(name)
  Project.find_by_name!(name)
end
