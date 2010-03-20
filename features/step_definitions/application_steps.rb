When /^(?:|I )click "([^\"]*)"$/ do |link|
  click_link(link)
end

When /the email has the subject \"(.*)\"/ do |subject|
  current_email.should have_subject(subject)
end

When /the email (?:is|should be) from \"(.*)\"/ do |from|
  current_email.should be_delivered_from(from)
end

When /the email should contain \"(.*)\"/ do |text|
  current_email.body.should include(text)
end

When /the email should contain a link to \"(.*)\".*/ do |url|
  current_email.body.should include(url)
end

When /click the (?:confirm|reset) link in the email/ do
  click_first_link_in_email
end

When /\"(.*)\" (?:is|should be|has been) confirmed/ do |email|
  User.find_by_email(email).should be_confirmed
end

When /\"(.*)\" (?:is|should be|has) not (?:been )confirmed/ do |email|
  User.find_by_email(email).should_not be_confirmed
end

Then /^I should see a link named "([^\"]*)"$/ do |text|
  response.body.should have_selector('a', :content => text)
end

Then /^I should not see a link named "([^\"]*)"$/ do |text|
  response.body.should_not have_selector('a', :content => text)
end

Then /server should return not found$/ do
  response.response_code.should == 404
end