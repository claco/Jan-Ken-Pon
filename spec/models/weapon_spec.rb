require 'spec_helper'

describe Weapon do
  fixtures :weapons

  it "should create a weapon" do
    @weapon = Weapon.new(:name => 'Rock')
    @weapon.name.should == 'Rock'
  end

  it "should return id from to_i" do
    Weapon.find(1).to_i.should == 1
  end

  it "should return name from to_s" do
    Weapon.find(1).to_s.should == 'Rock'
  end
end