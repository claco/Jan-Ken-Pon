class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :mode_id, :null => false
      t.integer :player_id, :null => false
      t.integer :opponent_id, :null => false
      t.integer :winner_id
      t.integer :rounds, :null => false, :default => 1
      t.timestamps
    end

    add_index :games, [:mode_id, :player_id, :opponent_id, :winner_id], :name => 'games_ids'
  end

  def self.down
    drop_table :games
  end
end
