class CreateProjectPrizes < ActiveRecord::Migration
  def self.up
    create_table :project_prizes do |t|
      t.integer :project_id, :null=>false
      t.string :name, :null=>false
      t.text :description, :null=>false
      t.timestamps
    end
    execute "alter table project_prizes modify name varchar(255) character set utf8;"
    execute "alter table project_prizes modify description text character set utf8;"
  end

  def self.down
    drop_table :project_prizes
  end
end
