require 'spec_helper'

describe GameQueue do
  before(:each) do
    @valid_attributes = {
      :game_id => 1,
      :mode_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    GameQueue.create!(@valid_attributes)
  end
end
