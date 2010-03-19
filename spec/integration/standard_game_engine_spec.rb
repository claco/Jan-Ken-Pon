require 'spec_helper'

describe StandardGameEngine do
  before :each do
    @engine = StandardGameEngine.new
  end

  it "should create a standard game engine" do
    @engine.should be_an_instance_of(StandardGameEngine)
  end

  #TODO: factor a way to find weapons by id
  it "should have Rock, Paper and Scissors weapons" do
    @engine = StandardGameEngine.new
    @engine.weapons.length.should == 3
    @engine.weapons.first.name.should == 'Rock'
    @engine.weapons.second.name.should == 'Paper'
    @engine.weapons.third.name.should == 'Scissors'
  end

  it "should have Rock beat Scissors" do
    rock = @engine.weapons.first
    scissors = @engine.weapons.third

    winner = @engine.deliver(rock, scissors)
    winner.should == rock
    winner.name.should == 'Rock'
  end

  it "should have Rock beat Scissors" do
    rock = @engine.weapons.first
    scissors = @engine.weapons.third

    winner = @engine.deliver(scissors, rock)
    winner.should == rock
    winner.name.should == 'Rock'
  end

  it "should have Paper beat Rock" do
    rock = @engine.weapons.first
    paper = @engine.weapons.second

    winner = @engine.deliver(rock, paper)
    winner.should == paper
    winner.name.should == 'Paper'
  end

  it "should have Paper beat Rock" do
    rock = @engine.weapons.first
    paper = @engine.weapons.second

    winner = @engine.deliver(paper, rock)
    winner.should == paper
    winner.name.should == 'Paper'
  end

  it "should have Scissors beat Paper" do
    scissors = @engine.weapons.third
    paper = @engine.weapons.second

    winner = @engine.deliver(scissors, paper)
    winner.should == scissors
    winner.name.should == 'Scissors'
  end

  it "should have Scissors beat Paper" do
    scissors = @engine.weapons.third
    paper = @engine.weapons.second

    winner = @engine.deliver(paper, scissors)
    winner.should == scissors
    winner.name.should == 'Scissors'
  end

  it "should be a stalemate for two of the same" do
    rock = @engine.weapons.first
    paper = @engine.weapons.second
    scissors = @engine.weapons.third

    @engine.deliver(rock, rock).should be_nil
    @engine.deliver(paper, paper).should be_nil
    @engine.deliver(scissors, scissors).should be_nil
  end
end