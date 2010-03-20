require 'spec_helper'

describe "/account/confirm" do
  before(:each) do
  end

  def do_render
    render 'account/confirm'
  end

  it "should display error when the token is invalid" do
    flash[:notice] = 'Could not find account to activate'
    do_render
    
    response.should include_text 'Could not find account to activate'
  end
end
