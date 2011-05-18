class UserProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :project_updates
end
