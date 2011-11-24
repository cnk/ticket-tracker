When /^I create a ticket with the title "([^"]*)" and description "([^"]*)"$/ do |title, description|
  page.fill_in 'Title', :with => title
  page.fill_in 'Description', :with => description
  page.click_button 'Create Ticket'
end

Given /^that project has a ticket:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |attributes|
    @project.tickets.create!(attributes)
  end
end

Given /^"([^"]*)" has created a ticket in that project:$/ do |email, table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |attributes|
    attributes = attributes.merge!(:user => User.find_by_email!(email))
    @project.tickets.create!(attributes)
  end
end

When /^I change the description to be "([^"]*)"$/ do |description|
  page.fill_in 'Description', :with => description
  page.click_button 'Update Ticket'
end
