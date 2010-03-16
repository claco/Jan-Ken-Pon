Feature: Leaderboard
  In order to entice users to register an play
  As an internet user
  I want to be able to see my name in the "top" users leaderboard


  Scenario: Top users by victorious round count
    Given player 1 has won 50
	And player 2 has won 30
    When I go to the stats by count page
    Then I should see a list of top users by count
	And player 1 is the top user


  Scenario: Top users by rounds played
    Given player 1 has played 50
	And player 2 has played 60
    When I go to the stats by rounds page
    Then I should see a list of top users by count
	And player 2 is the top user


  Scenario: Top users by opponents played
    Given player 1 has played 50 opponents
	And player 2 has played 60 opponents
    When I go to the stats by opponents page
    Then I should see a list of top users by count
	And player 2 is the top user
