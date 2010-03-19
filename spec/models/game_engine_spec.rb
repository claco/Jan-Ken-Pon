require 'spec_helper'

describe GameEngine do
  before :each do
    @engine = GameEngine.new
  end

  it "should create a game engine" do
    @engine.should be_an_instance_of(GameEngine)
  end

  it "should have a rules engine" do
    @engine.rules_engine.should be_an_instance_of(RulesEngine)
  end

  it "should take a rules_engine param" do
    rules_engine = mock(RulesEngine)

    @engine = GameEngine.new(:rules_engine => rules_engine)
    @engine.rules_engine.should == rules_engine
  end

  it "should take a rules param ans pass them to the rules engine" do
    rule1 = lambda{'rule1'}
    rule2 = lambda{'rules2'}
    rules = [ rule1, rule2 ]
    rules_engine = mock(RulesEngine)
    rules_engine.should_receive(:add).with(rule1, rule2)

    @engine = GameEngine.new(:rules_engine => rules_engine, :rules => rules)
  end

  it "should throw an error if rules param is not an array" do
    lambda{ GameEngine.new(:rules => {}) }.should raise_error(ArgumentError)
  end

  it "should take a weapons param" do
    weapon = mock_model(Weapon, :id => 1, :name => 'Rock')
    weapons = [weapon]

    @engine = GameEngine.new(:weapons => weapons)
    @engine.weapons.should == weapons
  end

  it "should throw an error if weapons is not an array" do
    lambda{ GameEngine.new(:weapons => {}) }.should raise_error(ArgumentError)
  end

  it "should take two weapons and get the winner from the rules engine" do
    weapon1 = mock_model(Weapon)
    weapon2 = mock_model(Weapon)

    rule = lambda{ |a, b| b }
    rules_engine = mock_model(RulesEngine)
    rules_engine.should_receive(:add).with(rule)
    rules_engine.should_receive(:process).with(weapon1, weapon2).and_return(weapon1)

    @engine = GameEngine.new(:rules_engine => rules_engine, :rules => [rule], :weapons => [weapon1, weapon2])
    @engine.deliver(weapon1, weapon2).should == weapon1
  end

  it "should throw an error when deliver doesn't get 2 weapons" do
    lambda{ @engine.deliver }.should raise_error(ArgumentError)
    lambda{ @engine.deliver(mock_model(Weapon)) }.should raise_error(ArgumentError)
    lambda{ @engine.deliver(nil, nil) }.should raise_error(ArgumentError)
    lambda{ @engine.deliver('nil', {:foo => 'bar'}) }.should raise_error(ArgumentError)
  end
end