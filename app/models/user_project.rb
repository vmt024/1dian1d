class UserProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :project_updates

  after_save :update_project_timestamp

  # update project updated_at timestamp after user update the project details
  def update_project_timestamp
    self.project.updated_at = Time.now
    self.project.save
  end
end
