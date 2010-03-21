class Round < ActiveRecord::Base
  validates_presence_of :game_id

  belongs_to :game
  belongs_to :player_weapon,   :class_name => 'Weapon'
  belongs_to :opponent_weapon, :class_name => 'Weapon'
  belongs_to :winning_weapon,  :class_name => 'Weapon'

  def already_made_choice?(player)
    if self.game.player_id == player.id && !self.player_weapon_id.blank?
      true
    elsif self.game.opponent_id == player.id && !self.opponent_weapon_id.blank?
      true
    else
      false
    end
  end

  def choose(player, weapon)
    if self.game.player_id == player.id
      self.player_weapon_id = weapon.to_i
    elsif self.game.opponent_id == player.id
      self.opponent_weapon_id = weapon.to_i
    end
  end

  def current_choice(player)
    self.game.player_id == player.id ? self.player_weapon : self.opponent_weapon
  end

  def have_both_weapons?
    if !self.player_weapon_id.blank? && !self.opponent_weapon_id.blank?
      true
    else
      false
    end
  end

  def winner
    if self.winning_weapon_id == self.player_weapon_id
      self.game.player
    elsif self.winning_weapon_id == self.opponent_weapon_id
      self.game.opponent
    else
      nil
    end
  end

  def reset
    self.player_weapon_id = nil
    self.opponent_weapon_id = nil
    self.winning_weapon_id = nil
  end

  def reset!
    self.reset
    self.save!
  end
end
