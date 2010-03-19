require 'spec_helper'

describe RulesEngine do
  before :each do
    @engine = RulesEngine.new
  end

  it "should create a rules engine" do
    @engine.should be_an_instance_of(RulesEngine)
  end

  it "shoud take a rules param to set rules" do
    rule = lambda{'rule1'}
    @engine = RulesEngine.new(:rules => [ rule ])
    @engine.rules.length.should == 1
    @engine.rules.first.should == rule
  end

  it "should be able to add rules" do
    rule = lambda{'rule1'}
    @engine.rules.length == 0
    @engine.add(rule)
    @engine.rules.length == 1
    @engine.rules.first.should == rule
  end

  it "shoud be able to add multiple rules" do
    rule1 = lambda{'rule1'}
    rule2 = lambda{'rule2'}

    @engine.add(rule1, rule2)
    @engine.rules.length.should == 2
  end

  it "should process weapons and return first matching rule" do
    weapon1 = mock_model(Weapon, :id => 1, :name => 'Rock')
    weapon2 = mock_model(Weapon, :id => 2, :name => 'Paper')

    rule1 = lambda{ |a, b| a if a.id == 1 }
    rule2 = lambda{ |a, b| b if b.id == 1 }

    @engine.add(rule1)
    @engine.add(rule2)

    @engine.process(weapon1, weapon2).name.should == 'Rock'
    @engine.process(weapon2, weapon1).name.should == 'Rock'
  end

  it "should return nil for no rules" do
    weapon1 = mock_model(Weapon, :id => 1, :name => 'Rock')
    weapon2 = mock_model(Weapon, :id => 2, :name => 'Paper')

    @engine.process(weapon1, weapon2).should be_nil
  end

  it "should consider no winner a draw (nil)" do
    weapon = mock_model(Weapon, :id => 1, :name => 'Rock')

    rule = lambda{ |a, b| nil if a.id == b.id }

    @engine.add(rule)
    @engine.process(weapon, weapon).should be_nil
  end

  it "should throw an error when process doesn't get 2 weapons" do
    lambda{ @engine.process }.should raise_error(ArgumentError)
    lambda{ @engine.process(mock_model(Weapon)) }.should raise_error(ArgumentError)
    lambda{ @engine.process(nil, nil) }.should raise_error(ArgumentError)
    lambda{ @engine.process('nil', {:foo => 'bar'}) }.should raise_error(ArgumentError)
  end
end