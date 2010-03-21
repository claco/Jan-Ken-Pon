class Player < ActiveRecord::Base
  attr_accessor :weapon

  validates_presence_of :name
  validates_uniqueness_of :name

  belongs_to :user

  def open_games
    Game.find(:all, :include => [:mode], :conditions => ["(player_id = ? OR opponent_id = ?) AND winner_id IS NULL", self.id, self.id])
  end
end