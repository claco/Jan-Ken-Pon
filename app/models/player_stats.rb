class PlayerStats < ActiveRecord::Base
  set_table_name "player_stats"
  belongs_to :player

  class << self
    def increment_winner!(player)
      self.find_or_create_by_player_id(player.id).increment!(:wins)
    end

    def leaders(max=5)
      self.find(:all, :limit => max, :order => 'wins DESC', :include => :player)
    end
  end
end
