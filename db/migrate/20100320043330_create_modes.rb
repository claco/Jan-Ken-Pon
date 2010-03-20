class CreateModes < ActiveRecord::Migration
  def self.up
    create_table :modes do |t|
      t.string :name, :null => false
      t.string :description
      t.text :rules
    end
  end

  def self.down
    drop_table :modes
  end
end
