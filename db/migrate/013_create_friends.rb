class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends,:option=>"DEFAULT CHARSET=UTF-8 ENGINE MyISAM" do |t|
      t.integer :user_id,:null=>false
      t.integer :friend_id,:null=>false
      t.timestamps
    end
    add_index :friends, :user_id
    add_index :friends, :friend_id
  end

  def self.down
    drop_table :friends
  end
end
