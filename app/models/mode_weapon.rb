class ModeWeapon < ActiveRecord::Base
  belongs_to :mode
  belongs_to :weapon
end
