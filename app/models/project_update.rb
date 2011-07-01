class ProjectUpdate < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  after_save :update_project_timestamp

  # update project updated_at timestamp after update/create
  # new project update
  def update_project_timestamp
    self.project.updated_at = Time.now
    self.project.save
  end
end
