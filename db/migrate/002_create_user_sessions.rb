class CreateUserSessions < ActiveRecord::Migration
  def self.up
    create_table :user_sessions,:option=>"ENGINE MyISAM" do |t|
      t.integer :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :user_sessions
  end
end
