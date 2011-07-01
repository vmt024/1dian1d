class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  after_save :update_project_timestamp

  # update the project 'updated at' timestamp
  # so the project with latest change will show first in the list
  def update_project_timestamp
    self.project.updated_at = Time.now
    self.project.save
  end
end
