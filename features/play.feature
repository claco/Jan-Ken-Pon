Feature: Play Jan Ken Pon
  In order to generate massive street cred
  As an internet user
  I want to be able to play Jan Ken Pon against opponents
  
  Scenario: Create a new game
    Given I am a registered user
	And I am on the home page
    When click "New Game"
    Then a new game is created
	And I am on the new game page
	And I should see "Waiting for opponent"


  Scenario: Join a game
    Given I am a registered user
	And I am on the home page
	And there is another user waiting for an opponent
	When I click "Join Game"
	Then I should join the game


  Scenario: Can't create a game without logging in
    Given I am not logged in
    When I go to the create game page
    Then I should be on the login page
	When I am login as "test@example.com|password"
	Then I should be on the game page


  Scenario: Can't join a game without logging in
    Given I am not logged in
	And there is a game waiting for a player
    When I go to the game page
    Then I should be on the login page
	When I am login as "test@example.com|password"
	Then I should be on the game page
