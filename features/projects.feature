Feature: Managing Projects
  As the administrator of a ticket tracker
  In order to organize my tickets
  I want to put them into projects

Scenario: create new project
  Given I am on the home page
  When I click on "New Project"
  And I create a project named "Content Management System"
  Then I should see "Project has been created." 

Scenario: create new project
  Given there is a project named "Desing"
  And I am on the home page
  When I click on "Edit"
  And I change the name to "Design"
  Then I should see "Project has been updated." 
  And I should see "Design"