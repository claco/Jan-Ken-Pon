Feature: Register
  In order to play Jan Ken Pon and invite others to play
  As a new user
  I want to be able to register


  Scenario: Register new user
    Given I am a new user
    And I am on the home page
    And I see "Register Now!"
    When I click "Register Now!"
	And I fill in "Email" with "test@user@example.com"
	And I fill in "Password" with "password"
	And I click "Register"
	Then I should see "confirmation sent to test@example.com"
	And I should see "New Game"
	And I should see "Join Game"


  Scenario: Confirmation email
    Given I register as "test@example.com|password"
    Then "test@example.com" should receive 1 email
    And when I open the email
	Then I see "JanKenPon Email Confirmation" in the subject
	And I see "confirm your email address" in the body
	And I see a confirmation link in the body
	When I click the confirmation link
	Then I am on the confirmation page
	And I should see "Thank you for registering"
