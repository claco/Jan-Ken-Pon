class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string     :email,               :null => false
      t.string     :name,                :null => false
      t.boolean    :confirmed,           :null => false, :default => false
      t.string     :password_hash,       :null => false
      t.string     :password_salt,       :null => false
      t.string     :persistence_token,   :null => false
      t.string     :single_access_token, :null => false
      t.string     :perishable_token,    :null => false
      t.integer    :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer    :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime   :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime   :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime   :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string     :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string     :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns
      t.timestamps
    end

    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
