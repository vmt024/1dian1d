class CreateProjectUpdates < ActiveRecord::Migration
  def self.up
    create_table :project_updates,:option=>"DEFAULT CHARSET=UTF-8 ENGINE MyISAM" do |t|
      t.integer :project_id, :null=>false
      t.text :content, :null=>false
      t.timestamps
    end
    execute "alter table project_updates modify content text character set utf8;"
    add_index :project_updates, :project_id
  end

  def self.down
    drop_table :project_updates
  end
end
