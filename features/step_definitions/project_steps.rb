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

Then /^I should be on the project page for "([^"]*)"$/ do |name|
  @project = Project.find_by_name(name)
  puts "figure out how to check page"
end
