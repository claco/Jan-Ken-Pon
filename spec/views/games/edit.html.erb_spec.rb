require 'spec_helper'

describe "/games/edit.html.erb" do
  include GamesHelper

  before(:each) do
    assigns[:game] = @game = stub_model(Game,
      :new_record? => false
    )
  end

  it "renders the edit game form" do
    render

    response.should have_tag("form[action=#{game_path(@game)}][method=post]") do
    end
  end
end
