Feature:Editing a user 
In orderto change a user's details 
As an admin 
I want to be able to modify themthrough the backend 

Background: 
  Given there are the following users: 
    | email             | password | admin | 
    | admin@tickets.com | password | true  | 
  And I am signed in as them 
  Given there are the following users: 
    | email            | password | 
    | user@tickets.com | password | 
  Given I am on the homepage 
  When I click on "Admin" 
  And I click on "Users" 
  And I click on "user@tickets.com" 
  And I click on "Edit User" 

Scenario: Updating a user's details 
  When I fill in "Email" with "newguy@tickets.com" 
  And I click the "Update User" button
  Then I should see "User has been updated." 
  And I should see "newguy@tickets.com" 
  And I should not see "user@tickets.com" 

Scenario: Toggling a user's adminability 
  When I check "Is an admin?" 
  And I click the "Update User" button
  Then I should see "User has been updated." 
  And I should see "user@tickets.com (Admin)" 

Scenario: Updating with an invalid email fails 
  When I fill in "Email" with "fakefakefake" 
  And I click the "Update User" button
  Then I should see "User has not been updated." 
  And I should see "Email is invalid" 
