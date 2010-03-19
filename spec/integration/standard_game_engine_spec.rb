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
    player1 = Player.new(:id => 1, :weapon => rock)
    player2 = Player.new(:id => 2, :weapon => scissors)

    winner = @engine.deliver(player1, player2)
    winner.should == player1
    winner.weapon.should == rock
    winner.weapon.name.should == 'Rock'

    winner = @engine.deliver(player2, player1)
    winner.should == player1
    winner.weapon.should == rock
    winner.weapon.name.should == 'Rock'
  end

  it "should have Paper beat Rock" do
    rock = @engine.weapons.first
    paper = @engine.weapons.second
    player1 = Player.new(:id => 1, :weapon => rock)
    player2 = Player.new(:id => 2, :weapon => paper)

    winner = @engine.deliver(player1, player2)
    winner.should == player2
    winner.weapon.should == paper
    winner.weapon.name.should == 'Paper'

    winner = @engine.deliver(player2, player1)
    winner.should == player2
    winner.weapon.should == paper
    winner.weapon.name.should == 'Paper'
  end

  it "should have Scissors beat Paper" do
    scissors = @engine.weapons.third
    paper = @engine.weapons.second
    player1 = Player.new(:id => 1, :weapon => scissors)
    player2 = Player.new(:id => 2, :weapon => paper)

    winner = @engine.deliver(player1, player2)
    winner.should == player1
    winner.weapon.should == scissors
    winner.weapon.name.should == 'Scissors'

    winner = @engine.deliver(player2, player1)
    winner.should == player1
    winner.weapon.should == scissors
    winner.weapon.name.should == 'Scissors'
  end

  it "should be a stalemate for two of the same" do
    rock = @engine.weapons.first
    paper = @engine.weapons.second
    scissors = @engine.weapons.third
    player1 = Player.new(:id => 1)
    player2 = Player.new(:id => 2)

    [rock, paper, scissors].each do |weapon|
      player1.weapon = weapon
      player2.weapon = weapon

      @engine.deliver(player1, player2).should be_nil
    end
  end
end