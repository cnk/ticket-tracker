Feature: Viewing Projects
  To protext our project's privacy
  Only certain users should be able to see some projects (and its tickets)

Background:
  Given there are the following users:
    | email      	      | password  | 
    | user@tickets.com	      | password  | 
  And I am signed in as them
  And there is a project named "Textmate 2"
  And "user@tickets.com" can view the "Textmate 2" project

Scenario: Listing projects
  Given I am on the homepage
  Then I should see "Textmate 2"
  When I click on "Textmate 2"
  Then I should be on the project page for "Textmate 2"
