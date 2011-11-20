Feature: Editing tickets
A user should be able to edit a ticket

Background:
  Given there is a project named "Textmate 2"
  And that project has a ticket: 
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


