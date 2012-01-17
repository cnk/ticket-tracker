Given /^there are the following users:$/ do |table|
  table.hashes.each do |attributes|
    # Default unconfirmed to false.
    # This line only returns true if unconfirmed is defined and set to "true"
    unconfirmed = attributes.delete("unconfirmed") == "true"
    @user = User.create!(attributes)
    @user.update_attribute("admin", attributes["admin"] == "true")
    # confirm the user we just created - unless you need it unconfirmed to test sign up proceedure
    @user.confirm! unless unconfirmed
  end
end

Given /^I am signed in as them$/ do
  steps(%Q{ 
      Given I am on the homepage 
      When I click on "Sign in" 
      And I fill in "Email" with "#{@user.email}" 
      And I fill in "Password" with "password" 
      And I click the "Sign in" button
      Then I should see "Signed in successfully." 
  }) 
end

Given /^I am signed in as "([^"]*)"$/ do |email|
  steps(%Q{ 
      Given I am on the homepage 
      When I click on "Sign in" 
      And I fill in "Email" with "#{email}" 
      And I fill in "Password" with "password" 
      And I click the "Sign in" button
      Then I should see "Signed in successfully." 
  }) 
end
