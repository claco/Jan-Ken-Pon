require 'spec_helper'

describe "/games/show.html.erb" do
  include GamesHelper
  before(:each) do
    assigns[:game] = @game = stub_model(Game)
  end

  it "renders attributes in <p>" do
    render
  end
end
