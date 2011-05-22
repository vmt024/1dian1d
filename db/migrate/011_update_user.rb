class UpdateUser < ActiveRecord::Migration
  def self.up
    add_column :users,:last_login_time,:timestamp
    add_column :users,:current_login_time,:timestamp
    add_column :users,:last_login_ip,:string
    add_column :users,:current_login_ip,:string
  end

  def self.down
    remove_column :users,:last_login_time
    remove_column :users,:current_login_time
    remove_column :users,:last_login_ip
    remove_column :users,:current_login_ip
  end
end
