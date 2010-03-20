require 'spec_helper'

describe "/account/forgot" do
  before(:each) do
    template.stub!(:authenticated? => false)
    template.stub!(:current_user => nil)
  end

  def do_render
    render 'account/forgot'
  end

  it "should have a form with email" do
    template.stub!(:authenticated? => false)
    user = mock_model(User)
    template.stub!(:current_user => user)
    do_render

    response.should have_tag "form[action=?]", forgot_path do
      with_tag 'label', :text => 'Email Address'
      with_tag "input[type=text]", :name => 'User[email]'
      with_tag "input[type=submit][value=Reset]"
    end
  end

  it "should display sent email message" do
    flash[:notice] = 'has been sent'
    do_render
    
    response.should include_text 'has been sent'
  end
end