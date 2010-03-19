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

  it "should raise error without an id" do
    lambda{ Player.new }.should raise_error(ArgumentError)
  end

  it "should raise error with 0 id" do
    lambda{ Player.new(:id => 0) }.should raise_error(ArgumentError)
  end
end