class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :option=>"DEFAULT CHARSET=UTF-8 ENGINE MyISAM" do |t|
      t.string :email, :limit => 255, :null => false
      t.text :description
      t.string :location
      t.string :crypted_password, :limit => 255, :null => false
      t.string :password_salt, :limit => 255, :null => false
      t.string :name, :limit => 255, :null => false
      t.string :username, :limit=>50
      t.string :superman, :limit => 4, :null => false, :default=>"NO"
      t.timestamps
    end
    execute "alter table users modify name varchar(255) character set utf8;"
    execute "alter table users modify location varchar(255) character set utf8;"
    execute "alter table users modify description text character set utf8;"
    add_index :users, :email
    add_index :users, :name
    add_index :users, :location
  end

  def self.down
    drop_table :users
  end
end
