When /^I create a project named "([^"]*)"$/ do |name|
  fill_in 'Name', with: name
  click_button 'Create'
end
