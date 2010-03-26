require 'spec_helper'

describe ModeWeapon do
  before(:each) do
    @valid_attributes = {
      :weapon_id => 1, :mode_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ModeWeapon.create!(@valid_attributes)
  end
end
