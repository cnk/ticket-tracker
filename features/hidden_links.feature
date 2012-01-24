Feature: Hidden Links
In order to not tease normal users
We should not show them links to functionality they can't use

Background: 
  Given there are the following users:
    | email      	      | password  | admin | unconfirmed |
    | admin@tickets.com	      | password  | true  | false	|
    | priv_user@tickets.com   | password  | false | false	|
    | user@tickets.com	      | password  | false | false	|
  And there is a project named "Project 1"
  And "user@tickets.com" has created a ticket in that project: 
    | title 	    | description            |
    | Make it shiny | Gradients! Starbursts! | 
  And "user@tickets.com" can view the "Project 1" project
  And "priv_user@tickets.com" can view the "Project 1" project
  And "priv_user@tickets.com" can create tickets on the "Project 1" project
  And "priv_user@tickets.com" can edit tickets on the "Project 1" project
  And "priv_user@tickets.com" can delete tickets on the "Project 1" project

Scenario Outline: Admins and privileged users can see links that are hidden from ordinary users
  Given I am signed in as "<user>"
  And I am on the home page
  When I click on "Project 1"
  Then I should see "Tickets"
  Then I <should-create-ticket> see the "New Ticket" link
  When I click on "Make it shiny" 
  Then I <should-edit-ticket> see the "Edit" link
  Then I <should-delete-ticket> see the "Delete" link

  Examples:
  | user                 | should-create-ticket | should-edit-ticket | should-delete-ticket |
  | user@tickets.com      | should not 		| should not 	     | should not 	    |
  | priv_user@tickets.com | should 		| should 	     | should 		    |
  | admin@tickets.com     | should 		| should 	     | should 		    |


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

