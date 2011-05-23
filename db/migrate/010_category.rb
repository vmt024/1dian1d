class Category < ActiveRecord::Migration
  def self.up
    create_table :categories,:option=>"DEFAULT CHARSET=UTF-8 ENGINE MyISAM" do |t|
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.string :name
      t.timestamps
    end
    execute "alter table categories modify name varchar(255) character set utf8;"
    add_index :categories, :name
  end

  def self.down
    drop_table :categories
  end
end
