class Weapon < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :icon

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
  end
end