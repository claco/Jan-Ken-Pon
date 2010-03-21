class Mode < ActiveRecord::Base
  validates_uniqueness_of :name

  has_many :mode_weapons
  has_many :weapons, :through => :mode_weapons

  def engine
    # TODO: This needs to be more dynamic, esp for user created game modes, but it will do for now.
    case self.id
    when 1
      @engine ||= StandardGameEngine.new
    when 2
      @engine ||= AdvancedGameEngine.new
    end
  end
end
