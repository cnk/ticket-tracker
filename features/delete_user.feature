Feature: Deleting users 
In order to remove users 
As an admin 
I want to click a button and delete them 

Background: 
  Given there are the following users: 
    | email | password | admin | 
    | admin@ticketee.com | password | true | 
    | user@ticketee.com | password | false | 
  And I am signed in as "admin@ticketee.com" 
  Given I am on the homepage 
  When I click on "Admin" 
  And I click on "Users" 

Scenario: Deleting a user 
  And I click on "user@ticketee.com" 
  When I click on "Delete User" 
  Then I should see "User has been deleted" 

Scenario: Users cannot delete themselves 
  When I click on "admin@ticketee.com" 
  And I click on "Delete User" 
  Then I should see "You cannot delete yourself!"
