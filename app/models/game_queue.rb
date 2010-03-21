class GameQueue < ActiveRecord::Base
  belongs_to :game
  belongs_to :mode

  validates_presence_of :game_id
  validates_presence_of :mode_id

  class << self
    def open_games
      #? https://rails.lighthouseapp.com/projects/8994/tickets/3208-belongs_to-with-primary_key-does-not-work-with-finds-include

      self.find(:all, :include => [:game, :mode]).collect{|q| q.game}
    end
  end
end
