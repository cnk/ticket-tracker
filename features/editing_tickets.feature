Feature: Editing and deleting tickets
A user should be able to edit a ticket

Background:
  Given there is a project named "Textmate 2"
  And there are the following users:
    | email 	    	      | password | admin |
    | user@tickets.com	      | password | false |
  And I am signed in as them
  And "user@tickets.com" has created a ticket in that project: 
    | title 	    | description            |
    | Make it shiny | Gradients! Starbursts! | 
  And I am on the home page
  When I click on "Textmate 2"
  And I click on "Make it shiny" 

Scenario: Edit a ticket with valid attributes
  When I click on "Edit"
  And I change the description to be "Split-screen editing"
  Then I should see "Ticket has been updated"
  And I should see "Split-screen editing"

Scenario: Edit a ticket with invalid attributes
  When I click on "Edit"
  And I change the description to be ""
  Then I should see "Editing ticket"
  And I should see "Description can't be blank"

Scenario: Deleting a ticket
  When I click on "Delete"
  # and how do I handle the "are you sure"?
  Then I should see "Ticket has been deleted"
  And I should see "Textmate 2"


