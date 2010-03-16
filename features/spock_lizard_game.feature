Feature: Spock Lizard game
  In order to be an advanced game
  As an advanced game
  I want to be able to play with Rock, Paper and Scissors, Lizard and Spock


  Background:
    Given I my options are Rock, Paper, Scissors, Lizard, Spock
	And Scissors beats Paper, Lizard
	And Paper beats Rock, Spock
	And Rock beats Scissors, Lizard
	And Lizard beats Spock, Paper
	And Spock beats Scissors, Rock
	And the game will have 1 round


  Scenario: Scissors cut Paper
    Given player 1 picks Scissors
	And player 2 picks Paper
    When the round is tallied
    Then player 1 is the winner


  Scenario: Scissors decapitate Lizard
    Given player 1 picks Scissors
	And player 2 picks Lizard
    When the round is tallied
    Then player 1 is the winner


  Scenario: Paper covers Rock
    Given player 1 picks Paper
	And player 2 picks Rock
    When the round is tallied
    Then player 1 is the winner


  Scenario: Paper disproves Spock
    Given player 1 picks Paper
	And player 2 picks Spock
    When the round is tallied
    Then player 1 is the winner


  Scenario: Rock crushes Lizard
    Given player 1 picks Rock
	And player 2 picks Lizard
    When the round is tallied
    Then player 1 is the winner


  Scenario: Rock crushes Scissors
    Given player 1 picks Rock
	And player 2 picks Scissors
    When the round is tallied
    Then player 1 is the winner


  Scenario: Lizard poisons Spock
    Given player 1 picks Lizard
	And player 2 picks Spock
    When the round is tallied
    Then player 1 is the winner


  Scenario: Lizard eats Paper
    Given player 1 picks Lizard
	And player 2 picks Paper
    When the round is tallied
    Then player 1 is the winner


  Scenario: Spock smashes Scissors
    Given player 1 picks Spock
	And player 2 picks Scissors
    When the round is tallied
    Then player 1 is the winner


  Scenario: Spock vaporizes Rock
    Given player 1 picks Spock
	And player 2 picks Rock
    When the round is tallied
    Then player 1 is the winner
