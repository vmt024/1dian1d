class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments,:option=>"DEFAULT CHARSET=UTF-8 ENGINE MyISAM" do |t|
      t.integer :user_id, :null=>false
      t.integer :project_id, :null=>false
      t.text :content, :null=>false
      t.timestamps
    end
    execute "alter table comments modify content text character set utf8;"
    add_index :comments, :user_id
    add_index :comments, :project_id
  end

  def self.down
    drop_table :comments
  end
end
