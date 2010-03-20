class StandardGameEngine < GameEngine
  def initialize
    super( {:weapons => weapons, :rules => rules} )
  end

  def rules
    [
      lambda{ |a,b| b if a.weapon.id == 1 && b.weapon.id == 2 },
      lambda{ |a,b| a if a.weapon.id == 1 && b.weapon.id == 3 },
      lambda{ |a,b| a if a.weapon.id == 2 && b.weapon.id == 1 },
      lambda{ |a,b| b if a.weapon.id == 2 && b.weapon.id == 3 },
      lambda{ |a,b| b if a.weapon.id == 3 && b.weapon.id == 1 },
      lambda{ |a,b| a if a.weapon.id == 3 && b.weapon.id == 2 }
    ]    
  end

  def weapons
    [
      Weapon.new(:id => 1, :name => 'Rock'),
      Weapon.new(:id => 2, :name => 'Paper'),
      Weapon.new(:id => 3, :name => 'Scissors')
    ]
  end
end