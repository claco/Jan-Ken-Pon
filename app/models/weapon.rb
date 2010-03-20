class Weapon < ActiveRecord::Base
  def to_i
    id
  end

  def to_s
    name
  end

  class << self
    def standard_weapons
      self.find(1, 2, 3)
    end
  end
end