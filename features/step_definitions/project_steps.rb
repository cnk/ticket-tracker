Given /^there is a project named "([^"]*)"$/ do |name|
  @project = Project.create!(:name => name)
end

When /^I change the name to "([^"]*)"$/ do |name|
  page.fill_in 'Name', :with => name
  page.click_button 'Update Project'
end

When /^I create a project named "([^"]*)"$/ do |name|
  fill_in 'Name', :with => name
  click_button 'Create'
end
