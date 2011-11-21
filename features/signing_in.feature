Feature: Signing in 
In order to use the site
As a user
I need to be able to sign in

Scenario: Signing in via confirmation email
  Given there are the following users:
    | email   	       | password | unconfirmed |
    | user@tickets.com | mypass	  | true	|
  And "user@tickets.com" opens the email with subject "Confirmation instructions"
  And they click the first link in the email
  Then I should see "Your account was successfully confirmed."
  And I should see "Signed in as user@tickets.com"

Scenario: Signing in via web form
  Given there are the following users:
    | email   	       | password | unconfirmed |
    | user@tickets.com | mypass	  | false	|
  And I am on the home page
  When I click on "Sign in"
  And I fill in "Email" with "user@tickets.com"
  And I fill in "Password" with "mypass"
  And I click the "Sign in" button
  Then I should see "Signed in successfully."

  
