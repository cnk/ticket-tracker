Feature: viewing tickets
A user should see tickets for a project on the project details page

Background:
  Given there are the following users:
    | email 	    	      | password | admin |
    | user@tickets.com	      | password | false |
  And I am signed in as them
  And there is a project named "Textmate 2"
  And "user@tickets.com" can view the "Textmate 2" project
  And "user@tickets.com" has created a ticket in that project: 
    | title 	    | description            |
    | Make it shiny | Gradients! Starbursts! | 
  And there is a project named "Internet Explorer" 
  And "user@tickets.com" can view the "Internet Explorer" project
  And "user@tickets.com" has created a ticket in that project: 
    | title 	           | description        |
    | Standards compliance | This isn't a joke! | 
  And I am on the home page

Scenario: Viewing tickets for a a specific project
  When I click on "Textmate 2"
  Then I should see "Make it shiny"
  And I should not see "Standards compliance"
  When I click on "Make it shiny"
  Then I should see "Gradients! Starbursts!"

  When I click on "All Projects"
  And I click on "Internet Explorer"
  Then I should see "Standards compliance"
  And I should not see "Make it shiny"
  When I click on "Standards compliance"
  Then I should see "This isn't a joke!"


