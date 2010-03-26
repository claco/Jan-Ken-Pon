require 'spec_helper'

describe PlayerStats do
  before(:each) do
    @valid_attributes = {
      :player_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    PlayerStats.create!(@valid_attributes)
  end
end
