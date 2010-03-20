require 'spec_helper'

describe Player do
  before :each do
    @player = Player.new(:id => 1)
  end

  it "shoud create a player" do
    @player.should be_an_instance_of(Player)
  end

  it "should take a weapon param" do
    weapon = mock_model(Weapon, :id => 1, :name => 'Rock')

    @player = Player.new(:id => 1, :weapon => weapon)
    @player.weapon.should == weapon
  end
end