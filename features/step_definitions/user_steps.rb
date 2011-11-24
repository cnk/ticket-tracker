Given /^there are the following users:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |attributes|
    # default to false; the line below only returns true if unconfirmed is "true"
    unconfirmed = attributes.delete("unconfirmed") == "true"
    @user = User.create!(attributes)
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
