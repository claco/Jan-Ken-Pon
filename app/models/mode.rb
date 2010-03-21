class Mode < ActiveRecord::Base
  validates_uniqueness_of :name

  has_many :mode_weapons
  has_many :weapons, :through => :mode_weapons

  def engine
    case self.id
    when 1
      @engine ||= StandardGameEngine.new
    end
  end
end
