require 'spec_helper'

describe "/authentication/login" do
  before(:each) do
  end

  #Delete this example and add some real ones or delete this file
  #it "should tell you where to find the file" do
  #  response.should have_tag('p', %r[Find me in app/views/authentication/login])
  #end

  def do_render
    render 'authentication/login'
  end

  it "should have a form with email/password" do
    do_render

    response.should have_tag "form[action=?]", login_path do
      with_tag 'label', :text => 'Email Address'
      with_tag 'label', :text => 'Password'
      with_tag "input[type=text]", :name => 'User[email]'
      with_tag "input[type=password]", :name => 'User[password]'
      with_tag "input[type=image][name=login]"
    end
  end
end
