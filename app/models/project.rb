class Project < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "538x288#", :thumb => "220x144#" }

  belongs_to :category
  has_many :user_projects
  has_many :supporters, :through=>:user_projects, :source=>:user
  belongs_to :owner, :class_name=>'User', :foreign_key => 'user_id'
  has_many :project_updates
  has_many :comments

  cattr_reader :per_page
  @@per_page = 10


  # return a list of locations for current projects
  def self.get_all_locations
    return Project.select('location').group("location")
  end
end
