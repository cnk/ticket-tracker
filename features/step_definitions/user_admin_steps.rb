Then /^I should be on the user creation form$/ do
  pass
end

When /^I fill out the new user form with "([^"]*)" and "([^"]*)"$/ do |email, password|
  page.fill_in 'Email', :with => email
  page.fill_in 'Password', :with => password
  page.fill_in 'Password confirmation', :with => password
end
