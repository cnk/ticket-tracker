# A couple of the things from web_steps.rb that I can't live without

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I click on "([^"]*)"$/ do |link|
  click_link link
end

When /^I click the "([^"]*)" button$/ do |button|
  click_button button
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  page.fill_in field, :with => value
end

When /^I check "([^"]*)"$/ do |link_text|
  page.check(link_text)
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "([^"]*)"$/ do |text|
  page.should_not have_content(text)
end

Then /^I should see a link to "([^\"]*)"$/ do |link_destination|
  page.should have_css("a[href=\"#{link_destination}\"]")
end

Then /^I should not see a link to "([^\"]*)"$/ do |link_destination|
  page.should_not have_css("a[href=\"#{link_destination}\"]")
end

Then /^I should see the "([^"]*)" link$/ do |link_text|
  page.should have_link(link_text)
end

Then /^I should not see the "([^"]*)" link$/ do |link_text|
  page.should have_no_link(link_text)
end

Then /^show me the page$/ do
  puts page.body
end
