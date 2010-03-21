# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
# Here for now. Usually better off as custom rake load task
Weapon.create!(:id => 1, :name => 'Rock',     :icon => 'rock.png')
Weapon.create!(:id => 2, :name => 'Paper',    :icon => 'paper.png')
Weapon.create!(:id => 3, :name => 'Scissors', :icon => 'scissors.png')
Weapon.create!(:id => 4, :name => 'Lizard', :icon => 'lizard.png')
Weapon.create!(:id => 5, :name => 'Spock', :icon => 'spock.png')
Mode.create!(:id => 1, :name => 'Rock, Paper, Scissors', :description => 'The Rock, Papar, Scissors we all know and love!')
Mode.create!(:id => 2, :name => 'Rock, Paper, Scissors, Lizard, Spock', :description => 'A more advanced version.')
ModeWeapon.create!(:mode_id => 1, :weapon_id => 1)
ModeWeapon.create!(:mode_id => 1, :weapon_id => 2)
ModeWeapon.create!(:mode_id => 1, :weapon_id => 3)
ModeWeapon.create!(:mode_id => 2, :weapon_id => 1)
ModeWeapon.create!(:mode_id => 2, :weapon_id => 2)
ModeWeapon.create!(:mode_id => 2, :weapon_id => 3)
ModeWeapon.create!(:mode_id => 2, :weapon_id => 4)
ModeWeapon.create!(:mode_id => 2, :weapon_id => 5)