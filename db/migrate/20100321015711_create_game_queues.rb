class CreateGameQueues < ActiveRecord::Migration
  def self.up
    create_table :game_queues do |t|
      t.references :game, :null => false
      t.references :mode, :null => false

      t.timestamps
    end
    
    add_index :game_queues, [:game_id, :mode_id]
  end

  def self.down
    drop_table :game_queues
  end
end
