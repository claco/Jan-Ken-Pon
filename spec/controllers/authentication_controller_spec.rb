require 'spec_helper'

describe AuthenticationController do
  before :each do
    controller.stub!(:authenticated?).and_return(false)    
  end

  #Delete these examples and add some real ones
  it "should use AuthenticationController" do
    controller.should be_an_instance_of(AuthenticationController)
  end

  describe "GET 'login'" do
    it "should be successful" do
      get 'login'
      response.should be_success
      response.should render_template("authentication/login")
    end
  end

  describe "POST 'login'" do
    it "should redirect to homepage after successful login" do
      session = mock_model(UserSession)
      UserSession.stub!(:new).and_return( session )
      session.stub!(:save).and_return(true)

      post 'login'
      response.should redirect_to(root_path)
    end

    it "should display error message for invalid password" do
      session = mock_model(UserSession)
      UserSession.stub!(:new).and_return( session )
      session.stub!(:save).and_return(false)

      post 'login'
      response.flash[:notice].should include_text('Invalid email address or password')
      response.should render_template("authentication/login")
    end
  end
  
  describe "GET 'logout'" do
    it "should redirect to homepage after logout without session" do
      UserSession.stub!(:find).and_return(nil)

      get 'logout'
      response.should redirect_to(root_path)
    end

    it "should redirect to homepage after logout with session" do
      session = mock_model(UserSession)
      UserSession.stub!(:find).and_return(session)
      UserSession.stub!(:destroy)
      session.should_receive(:destroy)

      get 'logout'
      response.should redirect_to(root_path)
    end
  end
end
