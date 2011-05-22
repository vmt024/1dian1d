class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages,:option=>"DEFAULT CHARSET=UTF-8 ENGINE MyISAM" do |t|
      t.integer :sender_id, :null=>false
      t.integer :receiver_id, :null=>false
      t.integer :reply_to_id
      t.string :content,:null=>false, :limit=>250
      t.boolean :read_yn,:null=>false, :default=> false
      t.timestamps
    end
    execute "alter table messages modify content varchar(250) character set utf8;"
    add_index :messages, :sender_id
    add_index :messages, :receiver_id
    add_index :messages, :reply_to_id
    add_index :messages, :read_yn
    
  end

  def self.down
    drop_table :messages
  end
end
