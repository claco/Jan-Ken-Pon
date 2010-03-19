require 'spec_helper'

describe Weapon do
  it "should create a weapon" do
    @weapon = Weapon.new(:id => 1, :name => 'Rock')
    @weapon.id.should == 1
    @weapon.name.should == 'Rock'
  end

  it "should return id from to_i" do
    Weapon.new(:id => 42, :name => 'Rock').to_i.should == 42
  end

  it "should throw an error when id is <= 0" do
    lambda{ Weapon.new(:id => 0) }.should raise_error(ArgumentError)
  end
end