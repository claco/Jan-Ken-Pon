require 'spec_helper'

describe "/games/new.html.erb" do
  include GamesHelper

  before(:each) do
    assigns[:game] = stub_model(Game,
      :new_record? => true
    )
  end

  it "renders new game form" do
    render

    response.should have_tag("form[action=?][method=post]", games_path) do
    end
  end
end
