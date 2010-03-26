require 'spec_helper'

describe "/account/create" do
  before(:each) do
  end

  def do_render
    render 'account/create'
  end

  it "should have a form with email/password" do        
    do_render

    response.should have_tag "form[action=?]", register_path do
      with_tag 'label', :text => 'Name'
      with_tag 'label', :text => 'Email Address'
      with_tag 'label', :text => 'Password'
      with_tag "input[type=text]", :name => 'User[name]'
      with_tag "input[type=text]", :name => 'User[email]'
      with_tag "input[type=password]", :name => 'User[password]'
      with_tag "input[type=image][name=register]"
    end
  end

  it "should complain about invalid email address formats" do
    template.stub!(:error_messages_for).with('user', 'player').and_return('email address is invalid')
    
    do_render
    response.should include_text('email address is invalid')
  end
end
