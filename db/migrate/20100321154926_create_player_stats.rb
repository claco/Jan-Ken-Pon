class CreatePlayerStats < ActiveRecord::Migration
  def self.up
    create_table :player_stats do |t|
      t.references :player, :null => false
      t.integer :wins, :null => false, :default => 0
      t.integer :losses, :null => false, :default => 0
    end

    add_index :player_stats, [:player_id, :wins, :losses]
  end

  def self.down
    drop_table :player_stats
  end
end
