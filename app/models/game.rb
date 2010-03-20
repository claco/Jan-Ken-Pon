class Game < ActiveRecord::Base
  validates_presence_of :type_id
  validates_presence_of :player_id
  validates_presence_of :opponent_id
end
