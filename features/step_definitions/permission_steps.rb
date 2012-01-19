Given /^"([^"]*)" can view the "([^"]*)" project$/ do |email, project_name|
  Permission.create!(:user => User.find_by_email!(email),
                     :thing => Project.find_by_name!(project_name),
                     :action => "view")
end
