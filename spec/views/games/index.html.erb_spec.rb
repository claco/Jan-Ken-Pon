require 'spec_helper'

describe "/games/index.html.erb" do
  include GamesHelper

  before(:each) do
    assigns[:games] = [
      stub_model(Game),
      stub_model(Game)
    ]
  end

  it "renders a list of games" do
    render
  end
end
