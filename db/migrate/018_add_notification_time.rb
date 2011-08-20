class AddNotificationTime < ActiveRecord::Migration
  def self.up
    add_column :users, :last_notification_time, :timestamp
    execute <<-sql
      update users set last_notification_time = last_login_time;
    sql

  end

  def self.down
    remove_column :users, :last_notification_time
  end
end
