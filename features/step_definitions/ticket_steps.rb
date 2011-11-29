When /^I create a ticket with the title "([^"]*)" and description "([^"]*)"$/ do |title, description|
  page.fill_in 'Title', :with => title
  page.fill_in 'Description', :with => description
  page.click_button 'Create Ticket'
end

Given /^"([^"]*)" has created a ticket in that project:$/ do |email, table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |attributes|
    @ticket = @project.tickets.build(attributes)
    @ticket.user = User.find_by_email!(email)
    @ticket.save!
  end
end

When /^I change the description to be "([^"]*)"$/ do |description|
  page.fill_in 'Description', :with => description
  page.click_button 'Update Ticket'
end
