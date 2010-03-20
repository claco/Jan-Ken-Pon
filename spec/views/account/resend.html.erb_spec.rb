require 'spec_helper'

describe "/account/resend" do
  before(:each) do
  end

  def do_render
    render 'account/resend'
  end

  it "should display resent message" do
    flash[:notice] = 'has been resent'
    do_render
    
    response.should include_text 'has been resent'
  end
end
