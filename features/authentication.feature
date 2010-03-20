Feature: Authentication
  In order to prevent anonymous users from spamming locations
  As an anonymous user
  I want to be able to log in


  Background:
    Given I an not logged in
	And I go to the home page
	And the User "user@example.com" with the password "password" already exists

  Scenario: Login as an existing user
	Given I see a link to "/login" named "Login"
    When I click "Login"
	And I fill in "Email Address" with "user@example.com"
	And I fill in "Password" with "password"
	And I press "Login"
    Then I should be on the home page
	And I should see "Welcome User"
	And I should not see a link to "/login" named "Login"

  Scenario: Invalid password
	Given I see a link to "/login" named "Login"
	When I click "Login"
	And I fill in "Email Address" with "user@example.com"
	And I fill in "Password" with "bogons"
	And I press "Login"
	Then I should see "Invalid email address or password"
	And I should be on the login page

  Scenario: Invalid email address
	Given I see a link to "/login" named "Login"
	When I click "Login"
	And I fill in "Email Address" with "bogons@example.com"
	And I fill in "Password" with "password"
	And I press "Login"
	Then I should see "Invalid email address or password"
	And I should be on the login page

  Scenario: Logout
    Given I am already logged in
    And I see a link to "/logout" named "Logout"
    When I click "Logout"
    Then I should be on the home page
	And I should not see "Welcome "
	And I should see a link to "/login" named "Login"
