Feature: Invites
  In order to garner as many registered users as possible
  As a registered user
  I want to be able to invite users to register and join my game


  Background:
    Given I am logged in as "test@example.com|password"
    And I my email is confirmed


  Scenario: Invite users to register
    Given I am on the home page
	And I see "Invite a friend!"
    When I click "Invite a friend!"
	And I fill in "Email" with "friend@example.com"
	And I press "Challenge"
	Then I should see "challenge has been sent"
	And "friend@example.com" should receive 1 email
	When I open the email
	Then I should see "JanKenPon Invitation" in the subject
	And I should see a registration link in the body
	When I click the register link
	Then I am on the registration page


  Scenario: Invite new user to current game
    Given "friend@example.com" is not a user
	And I start a new game
	And I see "Invite a friend"
    When I click "Invite a friend"
    And I fill in "Email" with "friend@example.com"
	And I press "Challenge"
	Then I should see "challenge has been sent"
	And "friend@example.com" should receive 1 email
	When I open the email
	Then I should see "JanKenPon Game Invitation" in the subject
	And I should see a registration link in the body
	When I click the register link
	Then I am on the registration page


  Scenario: Invite existing user to current game
    Given "friend@example.com" is a user
 	And I start a new game
	And I see "Invite a friend"
    When I click "Invite a friend"
    And I fill in "Email" with "friend@example.com"
	And I press "Challenge"
	Then I should see "challenge has been sent"
	And "friend@example.com" should receive 1 email
	When I open the email
	Then I should see "JanKenPon Game Invitation" in the subject
	And I should see a game link in the body
	When I click the game link
	Then I am on the game page


  Scenario: Accept game invitation as new user
    Given "friend@example.com" has created a new game
	And I received a game invite to the game
	And I am a new user
    When I open the email
	Then I should see "JanKenPon Game Invitation" in the subject
	And I should see a registration link in the body
	When I click the register link
	Then I am on the registration page
	When I fill in "Email" with "newuser@example.com"
	And I fill in "Password" with "password"
	And I press "Register"
	Then I should be on the game page 
