class AddAvatarToGoalProgress < ActiveRecord::Migration
  def self.up 
    add_column :project_updates, :avatar_file_name,    :string
    add_column :project_updates, :avatar_content_type, :string
    add_column :project_updates, :avatar_file_size,    :integer
    add_column :project_updates, :avatar_updated_at,   :datetime
  end

  def self.down
    remove_column :project_updates, :avatar_file_name
    remove_column :project_updates, :avatar_content_type
    remove_column :project_updates, :avatar_file_size
    remove_column :project_updates, :avatar_updated_at
  end
end
