class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false, :limit => 15

      t.timestamps
    end
    
    add_index :players, [:name], :unique => true
    add_index :players, [:user_id], :unique => true
  end

  def self.down
    drop_table :players
  end
end
