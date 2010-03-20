When /not logged in/ do
  visit path_to 'the logout page'
end

When /I logout/ do
  visit path_to 'the logout page'
end

When /already logged in/ do
  #Given "the User \"user@example.com\" with the password \"password\" already exists"
  Given "I click \"Login\""
	And "I fill in \"Email Address\" with \"user@example.com\""
	And "I fill in \"Password\" with \"password\""
	And "I press \"Login\""
	And "I am authenticated"
end

When /login as \"(.*)\"/ do |email|
  #Given "the User \"user@example.com\" with the password \"password\" already exists"
  And "I click \"Login\""
	And "I fill in \"Email Address\" with \"#{email}\""
	And "I fill in \"Password\" with \"password\""
	And "I press \"Login\""
	And "I am authenticated"
end

When /am authenticated/ do
  #Given "should see \"Welcome User\""
end

When /User \"(.*)\" does not exist/ do |email|
  User.find_by_email(email).should equal(nil)
end

When /the confirmed User \"(.*)\".*password \"(.*)\".*exists/ do |email, password|
  @user = User.create!(:name => 'User', :email => email, :password => password, :confirmed => true)
end

When /the User \"(.*)\".*password \"(.*)\".*exists/ do |email, password|
  @user = User.create!(:name => 'User', :email => email, :password => password)
end

When /not see.*link to \"(.*)\" named \"(.*)\"/ do |url, text|
  response.body.should_not have_selector('a', :href => url, :content => text)
end

When /I (?:|should )see.*link to \"(.*)\" named \"(.*)\"/ do |url, text|
  response.body.should have_selector('a', :href => url, :content => text)
end
