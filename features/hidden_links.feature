Feature: Hidden Links
In order to not tease normal users
We should not show them links to functionality they can't use

Background: 
  Given there are the following users:
    | email      	      | password  | admin | 
    | admin@tickets.com	      | password  | true  |
    | user@tickets.com	      | password  | false |
  And there is a project named "Project 1"

Scenario: Project admin links are not shown when you are not logged in
  Given I am on the home page
  Then I should not see the "New Project" link
  When I click on "Project 1"
  Then I should not see the "Edit" link
  And I should not see the "Delete" link

Scenario: Project admin links are not shown when you are logged in as a regular user
  Given I am signed in as "user@tickets.com"
  And I am on the home page
  Then I should not see the "New Project" link
  When I click on "Project 1"
  Then I should not see the "Edit" link
  And I should not see the "Delete" link

Scenario: Project admin links are shown when you are logged in as an admin user
  Given I am signed in as "admin@tickets.com"
  And I am on the home page
  Then I should see the "New Project" link
  When I click on "Project 1"
  Then I should see the "Edit" link
  And I should see the "Delete" link
