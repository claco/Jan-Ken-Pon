Feature: Accounts
  In order to allow users to login and add locations
  As a new user
  I want create a new account and verify my email address


  Background:
    Given I an not logged in
	And I go to the home page


  Scenario: Create a new account
    Given I see a link to "/register" named "Register"
    When I click "Register"
	And I fill in "Name" with "User"
	And I fill in "Email Address" with "user@example.com"
	And I fill in "Password" with "password"
	And I press "Register"
    Then I should see "Account created"
    And I should be on the account edit page
	And I should see "email has been sent to user@example.com"
	Then "user@example.com" should receive 1 email
	When I open the email
	Then the email has the subject "Jan Ken Pon Email Confirmation"
	And the email should be from "noreply@chrislaco.com"
	And the email should contain "confirm your email address"
	And the email should contain a link to "/confirm"
	When I click the confirm link in the email
	Then I should see "Your email address has been confirmed."
	And "user@example.com" should be confirmed


  Scenario: Invalid email address
	Given I see a link to "/register" named "Register"
	When I click "Register"
	And I fill in "Name" with "User"
	And I fill in "Email Address" with "example.com"
	And I fill in "Password" with "password"
	And I press "Register"
	Then I should see "Email address is invalid"


  Scenario: Empty fields
	Given I see a link to "/register" named "Register"
	When I click "Register"
	And I press "Register"
	Then I should see "Email address is required"
	And I should see "Password is required"
	And I should see "Name is required"


  Scenario: Resend confirmation
    Given the User "user@example.com" with the password "password" already exists
	And "user@example.com" has not been confirmed
	And I login as "user@example.com"
	And I go to the account edit page
	And I see a link to "/account/resend" named "Resend Confirmation"
    When I click "Resend Confirmation"
	Then I should see "email has been sent to user@example.com"
	Then "user@example.com" should receive 1 email
	When I open the email
	And the email has the subject "Jan Ken Pon Email Confirmation"
	And the email should contain "confirm your email address"
	And the email should contain a link to "/confirm"
	When I click the confirm link in the email
	Then I should see "Your email address has been confirmed."
	And "user@example.com" should be confirmed


  Scenario: Resend confirmation fails for confirmed
    Given the confirmed User "user@example.com" with the password "password" already exists
	And I login as "user@example.com"
	And I go to the account resend page
	Then I should see "already been confirmed"


  Scenario: Forgot password
    Given the User "user@example.com" with the password "password" already exists
    And I see a link to "/forgot" named "Forgot password?"
    When I click "Forgot password?"
	And I fill in "Email Address" with "user@example.com"
	And I press "Reset"
	Then I should see "email has been sent to user@example.com"
	Then "user@example.com" should receive 1 email
	And I open the email
	And the email has the subject "Jan Ken Pon Password Request"
	And the email should contain "reset your password"
	And the email should contain a link to "/reset"
	When I click the reset link in the email
	Then I should see "Enter your new password"
	When I fill in "New Password" with "newpassword"
	And I fill in "Confirm Password" with "otherpassword"
	And I press "Update"
	Then I should see "passwords do not match"
	When I fill in "New Password" with "newpassword"
	And I fill in "Confirm Password" with "newpassword"
	And I press "Update"
	Then I should see "password has been changed"


  Scenario: Change password
    Given the User "user@example.com" with the password "password" already exists
	And I login as "user@example.com"
	And I go to the account edit page
	And I fill in "New Password" with "newpassword"
	And I fill in "Confirm Password" with "otherpassword"
	When I press "Update"
	Then I should see "Passwords do not match"
	When I fill in "New Password" with "newpassword"
	And I fill in "Confirm Password" with "newpassword"
	And I press "Update"
	Then I should see "password has been changed"
	Then I logout
	And I go to the home page
	And I click "Login"
	And I fill in "Email Address" with "user@example.com"
	And I fill in "Password" with "newpassword"
	And I press "Login"
    Then I should be on the home page
	And I should see "Welcome User"


  Scenario: Email already exists
  	Given the User "user@example.com" with the password "password" already exists
    And I see a link to "/register" named "Register"
    When I click "Register"
	And I fill in "Name" with "User"
	And I fill in "Email Address" with "user@example.com"
	And I fill in "Password" with "password"
	And I press "Register"
    Then I should see "Email address already exists"


  Scenario: Change email address
    Given the confirmed User "user@example.com" with the password "password" already exists
	And the User "newuser@eaxmple.com" does not exist
	And I login as "user@example.com"
	And "user@example.com" should be confirmed
	When I go to the account edit page
	And I fill in "Email Address" with "newuser@example.com"
	When I press "Update"
	Then I should see "Account updated"
	And "newuser@example.com" has not been confirmed
	And I should see "email has been sent to newuser@example.com"
	Then "newuser@example.com" should receive 1 email
	When I open the email
	And the email has the subject "Jan Ken Pon Email Confirmation"
	And the email should contain "confirm your email address"
	And the email should contain a link to "/confirm"
	When I click the confirm link in the email
	Then I should see "Your email address has been confirmed."


  Scenario: Change email address to existing email address
    Given the User "user@example.com" with the password "password" already exists
	And the User "newuser@example.com" with the password "password" already exists
	And I login as "user@example.com"
	And I go to the account edit page
	And I fill in "Email Address" with "newuser@example.com"
	When I press "Update"
	Then I should see "address already exists"

