class StandardGameEngine < GameEngine
  @@weapons = [
    Weapon.new(:id => 1, :name => 'Rock'),
    Weapon.new(:id => 2, :name => 'Paper'),
    Weapon.new(:id => 3, :name => 'Scissors')
  ]

  @@rules = [
    lambda{ |a,b| b if a.id == 1 && b.id == 2 },
    lambda{ |a,b| a if a.id == 1 && b.id == 3 },
    lambda{ |a,b| a if a.id == 2 && b.id == 1 },
    lambda{ |a,b| b if a.id == 2 && b.id == 3 },
    lambda{ |a,b| b if a.id == 3 && b.id == 1 },
    lambda{ |a,b| a if a.id == 3 && b.id == 2 }
  ]
  def initialize
    super( {:weapons => @@weapons, :rules => @@rules} )
  end
end