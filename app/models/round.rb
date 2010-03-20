class Round < ActiveRecord::Base
  validates_presence_of :game_id

  belongs_to :game
  belongs_to :player_weapon,   :class_name => 'Weapon'
  belongs_to :opponent_weapon, :class_name => 'Weapon'
  belongs_to :winner_weapond,  :class_name => 'Weapon'
end
