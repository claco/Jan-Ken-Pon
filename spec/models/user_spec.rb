require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :email => 'user@example.com',
      :password => 'password',
      :name => 'User',
      :confirmed => false
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end

  it "should complain when email is not formatted correctly" do
    user = User.new(@valid_attributes)
    user.email = 'craptasic.com'
    user.should_not be_valid
    user.errors.on(:email).should == "Email address is invalid"
  end

  it "should complain about all required fields" do
    user = User.new()
    user.should_not be_valid
    user.errors.on(:name).should == "Name is required"
    user.errors.on(:email).should == "Email address is required"
    user.errors.on(:password).should == "Password is required"
  end

  it "should complain when the email address already exists" do
    user = User.create(@valid_attributes)

    user2 = User.new(@valid_attributes)
    user2.should_not be_valid
    user2.errors.on(:email).should == "Email address already exists"
  end

  it "should be able to mark a user as confirmed" do
    user = User.create(@valid_attributes)
    user.confirmed.should be_false
    user.confirm!
    user.confirmed.should be_true
  end
end
