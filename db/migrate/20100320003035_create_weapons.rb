class CreateWeapons < ActiveRecord::Migration
  def self.up
    create_table :weapons do |t|
      t.string :name, :null => false
      t.string :icon, :null => false
    end

    add_index :weapons, [:name], :unique => true
  end

  def self.down
    drop_table :weapons
  end
end
