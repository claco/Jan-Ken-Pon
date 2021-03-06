require 'spec_helper'

describe Game do
  before(:each) do
    @valid_attributes = {
      :mode_id => 1,
      :player_id => 1,
      :opponent_id => 1,
      :winner_id => 1,
      :total_rounds => 1,
      :completed_rounds => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Game.create!(@valid_attributes)
  end
end
