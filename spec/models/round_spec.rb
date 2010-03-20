require 'spec_helper'

describe Round do
  before(:each) do
    @valid_attributes = {
      :game_id => 1,
      :player_weapon_id => 1,
      :opponent_weapon_id => 1,
      :winner_weapon_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Round.create!(@valid_attributes)
  end
end
