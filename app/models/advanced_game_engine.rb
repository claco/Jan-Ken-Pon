class AdvancedGameEngine < GameEngine
  def initialize
    super( {:weapons => weapons, :rules => rules} )
  end

  def rules
    @rules ||= [
      lambda{ |a,b| b if a.weapon.id == 1 && b.weapon.id == 2 },
      lambda{ |a,b| a if a.weapon.id == 1 && b.weapon.id == 3 },
      lambda{ |a,b| a if a.weapon.id == 1 && b.weapon.id == 4 },
      lambda{ |a,b| b if a.weapon.id == 1 && b.weapon.id == 5 },

      lambda{ |a,b| a if a.weapon.id == 2 && b.weapon.id == 1 },
      lambda{ |a,b| b if a.weapon.id == 2 && b.weapon.id == 3 },
      lambda{ |a,b| b if a.weapon.id == 2 && b.weapon.id == 4 },
      lambda{ |a,b| a if a.weapon.id == 2 && b.weapon.id == 5 },

      lambda{ |a,b| b if a.weapon.id == 3 && b.weapon.id == 1 },
      lambda{ |a,b| a if a.weapon.id == 3 && b.weapon.id == 2 },
      lambda{ |a,b| a if a.weapon.id == 3 && b.weapon.id == 4 },
      lambda{ |a,b| b if a.weapon.id == 3 && b.weapon.id == 5 },

      lambda{ |a,b| b if a.weapon.id == 4 && b.weapon.id == 1 },
      lambda{ |a,b| a if a.weapon.id == 4 && b.weapon.id == 2 },
      lambda{ |a,b| b if a.weapon.id == 4 && b.weapon.id == 3 },
      lambda{ |a,b| a if a.weapon.id == 4 && b.weapon.id == 5 },

      lambda{ |a,b| a if a.weapon.id == 5 && b.weapon.id == 1 },
      lambda{ |a,b| b if a.weapon.id == 5 && b.weapon.id == 2 },
      lambda{ |a,b| a if a.weapon.id == 5 && b.weapon.id == 3 },
      lambda{ |a,b| b if a.weapon.id == 5 && b.weapon.id == 4 },
    ]    
  end

  def weapons
    @weapons ||= Weapon.advanced_weapons
  end
end