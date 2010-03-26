require 'spec_helper'

describe "/games/index.html.erb" do
  include GamesHelper

  before(:each) do
    mode = mock_model(Mode, :name => 'Rock, Paper, Scissors')
    assigns[:games] = [
      mock_model(Game, :key => 'abc', :name => 'Game1', :mode => mode)
    ]
  end

  it "renders a list of games" do
    render
  end
end
