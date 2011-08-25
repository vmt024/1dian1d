class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  attr_protected :user_id, :project_id, :created_at, :updated_at
  
  validates :content, :length => { :minimum => 1 }


  after_save :update_project_timestamp

  # update the project 'updated at' timestamp
  # so the project with latest change will show first in the list
  def update_project_timestamp
    unless self.user_id.eql?(self.project.user_id)
      self.project.updated_at = Time.now
      self.project.save
    end
  end
end
