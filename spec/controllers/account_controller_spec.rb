require 'spec_helper'

describe AccountController do
  before(:each) do
  end

  #Delete these examples and add some real one
  it "should use AccountController" do
    controller.should be_an_instance_of(AccountController)
  end


  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
      response.should render_template("account/create")
    end
  end

  describe "POST 'create'" do
    it "should redirect to edit page after successful create" do
      user = mock_model(User)
      player = mock_model(Player)
      User.stub!(:new).and_return( user )
      Player.stub(:new).and_return( player )
      user.stub!(:save!).and_return(true)
      user.stub!(:valid?).and_return(true)
      user.stub!(:email).and_return('user@example.com')
      user.stub!(:name).and_return('User')
      user.stub!(:perishable_token).and_return('token')
      player.stub!(:valid?).and_return(true)
      player.stub!(:save!).and_return(true)
      player.should_receive(:user=).with(user)

      Notifications.should_receive(:deliver_confirmation).with("user@example.com", "User", "token")

      post 'create'
      flash[:notice].should include('Account created')
      flash[:notice].should include('email has been sent to user@example.com')
      response.should redirect_to(root_url)
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      player = mock_model(Player)
      user = mock_model(User, :player => player)
      controller.stub!(:current_user).and_return(user)

      get 'edit'
      response.should be_success
      response.should render_template("account/edit")
    end
  end
  
  describe "POST 'edit'" do
    it "should display notice when email changed successfully" do
      player = mock_model(Player)
      user = mock_model(User, :player => player)

      User.stub!(:find_by_email).and_return(nil)
      controller.stub!(:current_user).and_return(user)
      user.stub!(:email=).with('user2@example.com')
      user.stub!(:email).and_return('user2@example.com')
      user.stub!(:name).and_return('User')
      user.stub!(:perishable_token).and_return('token')
      user.stub!(:confirmed=).with(false)
      user.should_receive(:confirmed=).with(false)
      user.should_receive(:name=).with('User')
      user.stub!(:save)
      player.should_receive(:name=).with('user')
      player.stub!(:save)

      post 'edit', :user => {:email => 'user2@example.com', :name => 'User'}, :player => {:name => 'user'}
      response.should redirect_to(account_path)
      flash[:notice].should include('Account updated')
      flash[:notice].should include('email has been sent to user2@example.com')
    end

    it "should display notice when email exists" do
      player = mock_model(Player)
      user = mock_model(User, :player => player)
      user.should_receive(:name=).with('User')
      User.stub!(:find_by_email).and_return(true)
      controller.stub!(:current_user).and_return(user)
      player.should_receive(:name=).with('user')
      user.stub!(:save)
      player.stub!(:save)

      post 'edit', :user => {:email => 'user2@example.com', :name => 'User'}, :player => {:name => 'user'}
      response.should be_success
      response.should render_template('account/edit')
      response.flash[:notice].should include('Email address already exists')
    end

    it "should display notice when passwords don't match" do
      player = mock_model(Player)
      player.should_receive(:name=).with('user')
      user = mock_model(User, :player => player)
      controller.stub!(:current_user).and_return(user)
      user.should_receive(:name=).with('User')
      user.should_receive(:save)
      player.should_receive(:save)

      post 'edit', :user => {:password => 'foo', :password_confirmation => 'bar', :name => 'User'}, :player => {:name =>'user'}
      response.should be_success
      response.should render_template('account/edit')
      response.flash[:notice].should include('Passwords do not match')
    end

    it "should change password when not blank and confirmed" do
      player = mock_model(Player)
      user = mock_model(User, :player => player)
      controller.stub!(:current_user).and_return(user)
      user.should_receive(:name=).with('User')
      user.stub!(:password=).with('newpass')
      user.stub!(:save)
      user.should_receive(:password=).with('newpass')
      player.should_receive(:name=).with('user')
      player.should_receive(:save)

      post 'edit', :user => {:password => 'newpass', :password_confirmation => 'newpass', :name => 'User'}, :player => {:name => 'user'}
      response.should redirect_to(account_path)
      flash[:notice].should include('Account updated')
      flash[:notice].should include('password has been changed')
    end
  end

  describe "GET 'confirm'" do
    it "should display confirmation when the token is valid" do
      user = mock_model(User)
      user.stub!(:confirm!)
            
      User.stub!(:find_using_perishable_token).and_return(user)
      User.should_receive(:find_using_perishable_token).with('mytoken')
      user.should_receive(:confirm!)

      get 'confirm', :token => 'mytoken'
      response.flash[:notice].should include('email address has been confirmed')
    end

    it "should return an error when the token is invalid" do    
      User.stub!(:find_using_perishable_token).and_return(nil)

      get 'confirm', :token => 'mytoken'
      response.flash[:notice].should include('Could not find account')
    end
  end

  describe "GET 'resend'" do
    it "should reset the perishable token and send a confirmation" do
      controller.stub!(:authenticated?).and_return(true)
      
      user = mock_model(User)
      user.stub!(:confirmed?).and_return(false)
      user.stub!(:reset_perishable_token!)
      user.stub!(:email).and_return('user@example.com')
      user.stub!(:name).and_return('User')
      user.stub!(:perishable_token).and_return('token')
      controller.stub(:current_user).and_return(user)
      user.should_receive(:reset_perishable_token!)
      Notifications.should_receive(:deliver_confirmation).with("user@example.com", "User", "token")
      
      get 'resend'
    end
  end

  describe "POST 'forgot'" do
    it "should reset the perishable token and send a reset link" do
      controller.stub!(:authenticated?).and_return(false)
      
      user = mock_model(User)
      user.stub!(:reset_perishable_token!)
      user.stub!(:email).and_return('user@example.com')
      user.stub!(:name).and_return('User')
      user.stub!(:perishable_token).and_return('token')
      User.stub!(:find_by_email).and_return(user)
      controller.stub(:current_user).and_return(user)
      user.should_receive(:reset_perishable_token!)
      Notifications.should_receive(:deliver_forgot_password).with("user@example.com", "User", "token")
      
      post 'forgot', :User => {:email => 'user@example.com'}
    end
  
    it "should return an error when the email is invalid" do    
      User.stub!(:find_by_email).and_return(nil)

      post 'forgot', :User => {:email => 'mytoken'}
      response.flash[:notice].should include('Could not find account')
    end
  end

  describe "GET 'reset'" do
    it "should display confirmation when the token is valid" do
      user = mock_model(User)
      User.stub!(:find_using_perishable_token).and_return(user)
      User.should_receive(:find_using_perishable_token).with('mytoken')

      get 'reset', :token => 'mytoken'
    end

    it "should return an error when the token is invalid" do    
      User.stub!(:find_using_perishable_token).and_return(nil)

      get 'reset', :token => 'mytoken'
      response.flash[:notice].should include('Could not find account')
    end
    
    it "should display notice when passwords don't match" do
      user = mock_model(User)
      User.stub!(:find_using_perishable_token).and_return(user)
      User.should_receive(:find_using_perishable_token).with('mytoken')
      controller.stub!(:current_user).and_return(user)

      post 'reset', :token => 'mytoken', :User => {:password => 'foo', :confirm_password => 'bar'}
      response.should be_success
      response.should render_template('account/reset')
      response.flash[:notice].should include('passwords do not match')
    end
    
    it "should change password when not blank and confirmed" do
      user = mock_model(User)
      User.stub!(:find_using_perishable_token).and_return(user)
      User.should_receive(:find_using_perishable_token).with('mytoken')
      user.stub!(:password=).with('newpass')
      user.stub!(:save)
      user.should_receive(:password=).with('newpass')

      post 'reset', :token => 'mytoken', :User => {:password => 'newpass', :confirm_password => 'newpass'}
      #response.should redirect_to(account_path)
      response.flash[:notice].should include('password has been changed')
    end
  end
end
