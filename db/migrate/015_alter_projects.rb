class AlterProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :success_yn, :boolean
  end

  def self.down
    remove_column :projects, :success_yn
  end
end
