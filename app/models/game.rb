require 'uuid'

class Game < ActiveRecord::Base
  validates_presence_of :key
  validates_presence_of :mode_id
  validates_presence_of :player_id
  validates_presence_of :opponent_id

  belongs_to :mode
  belongs_to :player
  belongs_to :opponent, :class_name => 'Player'
  belongs_to :winner, :class_name => 'Player'

  before_validation :create_key

  private
    # TODO: into helper
    def create_key
      if self.key.blank?
        self.key = UUID.create.to_i.to_s(36)
      end
    end
end
