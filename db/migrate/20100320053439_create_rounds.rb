class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.integer :game_id, :null => false
      t.integer :player_weapon_id
      t.integer :opponent_weapon_id
      t.integer :winning_weapon_id

      t.timestamps
    end

    add_index :rounds, [:game_id]
  end

  def self.down
    drop_table :rounds
  end
end
