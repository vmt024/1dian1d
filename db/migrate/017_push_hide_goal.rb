class PushHideGoal < ActiveRecord::Migration

  def self.up
    add_column :projects, :goal_value, :integer, :default=>20, :null=>false
    
    create_table :vote_histories do |t|
      t.integer :user_id, :null => false
      t.integer :project_id, :null => false
      t.boolean :push_or_hide, :null => false
    end
  
    add_index :vote_histories, :user_id
    add_index :vote_histories, :project_id
   
  end

  def self.down
    remove_column :projects, :goal_value
    drop_table :vote_histories
  end
end
