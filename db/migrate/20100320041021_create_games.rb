class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :key, :null => false, :limit => 25
      t.references :mode, :null => false
      t.references :player, :null => false
      t.integer :opponent_id
      t.integer :winner_id
      t.integer :total_rounds, :null => false, :default => 1
      t.integer :completed_rounds, :null => false, :default => 0
      t.timestamps
    end

    add_index :games, [:key, :mode_id, :player_id, :opponent_id, :winner_id], :name => 'games_ids'
  end

  def self.down
    drop_table :games
  end
end
