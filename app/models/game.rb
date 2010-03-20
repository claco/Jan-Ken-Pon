class Game < ActiveRecord::Base
  validates_presence_of :mode_id
  validates_presence_of :player_id
  validates_presence_of :opponent_id

  belongs_to :mode
  belongs_to :player
  belongs_to :opponent, :class_name => 'Player'
  belongs_to :winner, :class_name => 'Player'
end
