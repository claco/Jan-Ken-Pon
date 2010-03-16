Feature: Reverse game
  In order to challenge standard game masters
  As a reverse game
  I want to be able to play with Rock, Paper and Scissor reversed


  Background:
    Given I my options are Rock, Paper, Scissors
	And Paper beats Scissors
	And Rock beats Paper
	And Scissors beats Rock


  Scenario: Scissors cut Paper
    Given player 1 picks Scissors
	And player 2 picks Paper
    When the round is tallied
    Then player 2 is the winner


  Scenario: Scissors cut Paper
    Given player 1 picks Paper
	And player 2 picks Scissors
    When the round is tallied
    Then player 1 is the winner


  Scenario: Paper covers Rock
    Given player 1 picks Paper
	And player 2 picks Rock
    When the round is tallied
    Then player 2 is the winner


  Scenario: Paper covers Rock
    Given player 1 picks Rock
	And player 2 picks Paper
    When the round is tallied
    Then player 1 is the winner


  Scenario: Rock smashes Scissors
    Given player 1 picks Rock
	And player 2 picks Scissors
    When the round is tallied
    Then player 2 is the winner


  Scenario: Rock smashes Scissors
    Given player 1 picks Scissors
	And player 2 picks Rock
    When the round is tallied
    Then player 1 is the winner
