Feature: Creating tickets
  To start the bugfix or enhancement process
  As a user
  I need to be able to create tickets

Background: 
  Given there is a project named "Internet Explorer"
  And there are the following users:
    | email 	    	      | password | admin |
    | user@tickets.com	      | password | false |
  And "user@tickets.com" can view the "Internet Explorer" project
  And I am on the home page
  Then I should see "You need to sign in or sign up before continuing."
  When I fill in "Email" with "user@tickets.com"
  And I fill in "Password" with "password"
  And I click the "Sign in" button
  # We should be back on the project page, ready to create a ticket
  When I click on "Internet Explorer"
  When I click on "New Ticket"
  Then I should see "New ticket"

Scenario: Creating a ticket
  When I create a ticket with the title "Non-standards compliance" and description "My pages are ugly"
  Then I should see "Ticket has been created."
  And I should see "Created by user@tickets.com"

Scenario: Creating a ticket with missing data
  When I create a ticket with the title "" and description ""
  And I should see "Title can't be blank"
  And I should see "Description can't be blank"
