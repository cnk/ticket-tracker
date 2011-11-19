When /^I create a ticket with the title "([^"]*)" and description "([^"]*)"$/ do |title, description|
  page.fill_in 'Title', :with => title
  page.fill_in 'Description', :with => description
  page.click_button 'Create Ticket'
end
