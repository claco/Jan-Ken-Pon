require 'spec_helper'

describe Notifications do
  describe "Confirmation Email" do
    before(:all) do
      @email = Notifications.create_confirmation("user@example.com", "User", "token")
    end

    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to("user@example.com")
    end

    it "should be set to be delivered from noreply@helpnear.me" do
      @email.should deliver_from("noreply@chrislaco.com")
    end

    it "should contain the user's message in the mail body" do
      @email.should have_text(/Dear User/)
    end

    it "should contain the instructions" do
      @email.should have_text(/confirm your email address/)
    end

    it "should contain a link to the confirmation link" do
      @email.should have_text(/\/confirm\/token/)
    end

    it "should have the correct subject" do
      @email.should have_subject(/Jan Ken Pon Email Confirmation/)
    end
  end
  describe "Password Reset Email" do
    before(:all) do
      @email = Notifications.create_forgot_password("user@example.com", "User", "token")
    end

    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to("user@example.com")
    end

    it "should be set to be delivered from noreply@helpnear.me" do
      @email.should deliver_from("noreply@chrislaco.com")
    end

    it "should contain the user's message in the mail body" do
      @email.should have_text(/Dear User/)
    end

    it "should contain the instructions" do
      @email.should have_text(/reset your password/)
    end

    it "should contain a link to the confirmation link" do
      @email.should have_text(/\/reset\/token/)
    end

    it "should have the correct subject" do
      @email.should have_subject(/Jan Ken Pon Password Request/)
    end
  end
end
