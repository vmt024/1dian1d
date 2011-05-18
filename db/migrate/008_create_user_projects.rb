class CreateUserProjects < ActiveRecord::Migration
  def self.up
    create_table :user_projects,:id=>false do |t|
      t.integer :user_id, :null=>false
      t.integer :project_id, :null=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :user_projects
  end
end
