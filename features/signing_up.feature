Feature: Signing up
In order to know who is creating projects and filing tickets
I need to be able to sign up 

Scenario: Signing up
  Given I am on the home page
  When I click on "Sign up"
  And I fill in "Email" with "user@example.edu"
  And I fill in "Password" with "badpass"
  And I fill in "Password confirmation" with "badpass"
  And I click the "Sign up" button
  Then I should see "You have signed up successfully."
