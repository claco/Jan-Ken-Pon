class Weapon < ActiveRecord::Base
  has_many :mode_weapons
  has_many :modes, :through => :mode_weapons

  validates_presence_of :name
  validates_presence_of :icon
  validates_uniqueness_of :name

  def to_i
    id
  end

  def to_s
    name
  end

  class << self
    def standard_weapons
      # TODO: Needs caching
      self.find(1, 2, 3)
    end

    def advanced_weapons
      # TODO needs to be more dynamic
      self.find(1, 2, 3, 4, 5)
    end
  end
end