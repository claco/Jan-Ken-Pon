require 'uuid'

class Game < ActiveRecord::Base
  validates_presence_of :key
  validates_presence_of :mode_id
  validates_presence_of :player_id

  belongs_to :mode
  belongs_to :player
  belongs_to :opponent, :class_name => 'Player'
  belongs_to :winner, :class_name => 'Player'
  has_many :rounds

  before_validation :create_key

  # TODO: This method is long. factor it out a tad more.
  def deliver(player, weapon)
    if self.finished?
      raise ArgumentError, 'game is already over!'
    else
      if self.has_player?(player)
        if self.has_weapon?(weapon)
          round = self.current_round
          
          # TODO: deal with object and/or id
          if !round.winning_weapon_id.blank?
            raise ArgumentError, 'round has already been won!'
          elsif round.already_made_choice?(player)
            raise ArgumentError, 'you have already made your chice for this round!'
          else
            Game.transaction do
              round.choose(player, weapon)
              round.save!
              round.reload
            
              if round.have_both_weapons?
                player = self.player
                player.weapon = round.player_weapon
                opponent = self.opponent
                opponent.weapon = round.opponent_weapon

                winner = self.engine.process(player, opponent)
                
                # Draw/Tie
                if winner.blank?
                  round.reset!

                  return
                end
                
                round.winning_weapon_id = winner.weapon.id
                round.save!
                self.increment!(:completed_rounds)
              
                if self.completed_rounds == self.total_rounds
                  player_wins = self.rounds.select{|r| r.player_weapon_id == r.winning_weapon_id}.length
                  opponent_wins = self.rounds.select{|r| r.opponent_weapon_id == r.winning_weapon_id}.length
                
                  if player_wins > opponent_wins
                    self.winner_id = self.player_id
                  else
                    self.winner_id = self.opponent_id
                  end
                  self.save!
                  self.update_stats!
                end
              end
            end
          end
        else
          raise ArgumentError, 'weapon not allowed in this game!'
        end
      else
        raise ArgumentError, 'player not allowed in this game!'
      end    
    end
  end

  def previous_round
    self.rounds.find_by_number(self.completed_rounds)
  end

  def current_round
    if self.completed_rounds < self.total_rounds
      number = self.completed_rounds + 1

      self.rounds.find_or_create_by_number(number)
    else
      nil
    end
  end

  def current_choice(player)
    self.current_round.current_choice(player)
  end

  def engine
    @engine ||= self.mode.engine
  end

  def finished?
    if !self.winner_id.blank? || self.completed_rounds == self.total_rounds
      true
    else
      false
    end
  end

  def has_player?(player)
    if self.player_id == player.id || self.opponent_id == player.id
      true
    else
      false
    end
  end

  def has_all_players?
    if !self.player_id.blank? && !self.opponent_id.blank?
      true
    else
      false
    end
  end

  def has_weapon?(weapon)
    # to_i is id in weapon, or just an int from params
    weapons.select{|w| w.id == weapon.to_i}.length == 1
  end

  # TODO: my_opponent is more dsl, but find_opponent(player) is more AR like
  def find_opponent(player)
    self.player_id == player.id ? self.opponent : self.player
  end
  
  def already_made_choice?(player)
    current_round.already_made_choice?(player)
  end
  
  def weapons
    self.mode.weapons
  end

  def update_stats!
    PlayerStats.increment_winner!(self.winner)
  end

  private
    # TODO: into helper
    def create_key
      if self.key.blank?
        self.key = UUID.create.to_i.to_s(36)
      end
    end
end
