Feature: Creating tickets
  To start the bugfix or enhancement process
  As a user
  I need to be able to create tickets

Background: 
  Given there is a project named "Internet Explorer"
  And I am on the home page
  When I click on "Internet Explorer"
  And I click on "New Ticket"

Scenario: Creating a ticket
  When I create a ticket with the title "Non-standards compliance" and description "My pages are ugly"
  Then I should see "Ticket has been created."

Scenario: Creating a ticket with missing data
  When I create a ticket with the title "" and description ""
  And I should see "Title can't be blank"
  And I should see "Description can't be blank"
