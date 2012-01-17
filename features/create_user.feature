Feature: Creating users
In order to add more users to the system
As an admin
I want to be able to use the admin interface to manage users

Background:
  Given there are the following users:
  | email     	      | password | admin|
  | admin@tickets.com | password | true |
  And I am signed in as them
  Given I am on the home page
  When I click on "Admin"
  And I click on "Users"
  And I click on "New User"

Scenario: Creating a new user
  Then I should be on the user creation form
  When I fill out the new user form with "newuser@tickets.com" and "password"
  And I click the "Create User" button
  Then I should see "User has been created."

Scenario: Leaving email blank gives an error message
  Then I should be on the user creation form
  When I fill out the new user form with "" and "password"
  And I click the "Create User" button
  Then I should see "User has not been created."
  And I should see "Email can't be blank"
