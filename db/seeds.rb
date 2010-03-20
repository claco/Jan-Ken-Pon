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
