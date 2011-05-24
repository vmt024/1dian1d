class Project < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "538x288#", :thumb => "220x144#" }

  belongs_to :category
  has_and_belongs_to_many :supporters, :join_table=>:user_projects, :class_name=>'User'
  belongs_to :owner, :class_name=>'User', :foreign_key => 'user_id'
  has_many :project_updates
  has_many :comments

  cattr_reader :per_page
  @@per_page = 10


  def self.get_all_locations
    return Project.where(:all).select('location').group("location")
  end
end
