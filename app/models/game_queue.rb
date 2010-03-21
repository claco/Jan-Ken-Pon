class GameQueue < ActiveRecord::Base
  belongs_to :game
  belongs_to :mode

  validates_presence_of :game_id
  validates_presence_of :mode_id
end
