class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects,:option=>"DEFAULT CHARSET=UTF-8 ENGINE MyISAM" do |t|
      t.integer :user_id, :null=>false
      t.integer :category_id, :null=>false
      t.string :name, :null=>false
      t.text :description, :null=>false
      t.string :location, :null=>false
      t.datetime :complete_time, :null=>false
      t.integer :views,:null=>false,:default=>0
      t.integer :number_of_supporters, :null=>false, :default=>0
      t.timestamps
    end

    execute "alter table projects modify name varchar(255) character set utf8;"
    execute "alter table projects modify description text character set utf8;"
    execute "alter table projects modify location varchar(255) character set utf8;"
    add_index :projects, :user_id
    add_index :projects, :category_id
    add_index :projects, :name
    add_index :projects, :location
    add_index :projects, :views
    add_index :projects, :number_of_supporters

  end

  def self.down
    drop_table :projects
  end
end
