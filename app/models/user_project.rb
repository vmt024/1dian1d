class UserProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :project_updates

  after_save :update_project_timestamp

  def update_project_timestamp
    self.project.update_at = Time.now
    self.project.save
  end
end
