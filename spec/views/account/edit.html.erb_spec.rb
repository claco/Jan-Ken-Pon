require 'spec_helper'

describe "/account/edit" do
  before(:each) do
    template.stub!(:authenticated? => false)
    template.stub!(:current_user => nil)
  end

  def do_render
    render 'account/edit'
  end

  it "should display error when login sets notice" do
    flash[:notice] = 'Account created succesfully. A confirmation email has been sent to user@example.com'
    do_render
    
    response.should include_text "Account created"
    response.should include_text "email has been sent to user@example.com" 
  end

  it "should display a resend confirmaiton link for unconfirmed accounts" do
    template.stub!(:authenticated? => true)
    user = mock_model(User)
    user.stub!(:confirmed).and_return(false)
    template.stub!(:current_user => user)

    do_render

    response.should have_tag('a[href=?]', resend_path, :text => 'Resend Confirmation')
  end

  it "should not display a resend confirmaiton link for confirmed accounts" do
    template.stub!(:authenticated? => true)
    user = mock_model(User)
    user.stub!(:confirmed).and_return(true)
    template.stub!(:current_user => user)

    do_render
    response.should_not have_tag('a[href=?]', resend_path, :text => 'Resend Confirmation')
  end

  it "should have a form with email and pass/confirm" do
    template.stub!(:authenticated? => true)
    user = mock_model(User)
    user.stub!(:confirmed).and_return(false)
    template.stub!(:current_user => user)
    do_render

    response.should have_tag "form[action=?]", account_path do
      with_tag 'label', :text => 'Email Address'
      with_tag "input[type=text]", :name => 'User[email]'
      with_tag 'label', :text => 'New Password'
      with_tag "input[type=password]", :name => 'User[password]'
      with_tag 'label', :text => 'Confirm Password'
      with_tag "input[type=password]", :name => 'User[confirm_password]'
      with_tag "input[type=submit][value=Update]"
    end
  end

  it "should complain about invalid email address formats" do
    template.stub!(:authenticated? => true)
    user = mock_model(User)
    user.stub!(:confirmed).and_return(false)
    template.stub!(:current_user => user)
    template.stub!(:error_messages_for).with('user').and_return('email address is invalid')
    
    do_render
    response.should include_text('email address is invalid')
  end
end
