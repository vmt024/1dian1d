class CreateUserProjects < ActiveRecord::Migration
  def self.up
    create_table :user_projects,:id=>false,:option=>"DEFAULT CHARSET=UTF-8 ENGINE MyISAM" do |t|
      t.integer :user_id, :null=>false
      t.integer :project_id, :null=>false
      t.timestamps
    end
    add_index :user_projects, :user_id
    add_index :user_projects, :project_id

  end

  def self.down
    drop_table :user_projects
  end
end
