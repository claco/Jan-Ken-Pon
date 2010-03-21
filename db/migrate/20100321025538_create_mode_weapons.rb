class CreateModeWeapons < ActiveRecord::Migration
  def self.up
    create_table :mode_weapons do |t|
      t.references :mode, :null => false
      t.references :weapon, :null => false
    end
    
    add_index :mode_weapons, [:mode_id, :weapon_id]
  end

  def self.down
    drop_table :mode_weapons
  end
end
