class Project < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "538x288#", :thumb => "220x144#" }

  belongs_to :category
  has_many :user_projects
  has_many :supporters, :through=>:user_projects, :source=>:user
  belongs_to :owner, :class_name=>'User', :foreign_key => 'user_id'
  has_many :project_updates, :order =>"created_at DESC"
  has_many :comments, :order=>"created_at DESC"
  has_many :diggers ,:class_name=>'GoalDigger', :conditions=>{:push_or_hide => true}  # users who pushed goal
  has_many :buryers ,:class_name=>'GoalDigger', :conditions=>{:push_or_hide => false} # users who hide goal
  has_many :voters ,:class_name=>'GoalDigger' # all users who has digg or bury this project

  scope :current_projects, where('complete_time >= NOW()')
  scope :past_projects, where('complete_time < NOW()')
  scope :recommend_projects, where('goal_value >= 1')
  scope :hidden_projects, where('goal_value < 1')

  attr_protected :user_id, :views, :created_at, :updated_at, :goal_value
  cattr_reader :per_page
  @@per_page = 10

  validates :name, :length => { :minimum => 4, :maximum=> 17 }
  validates :description, :length => { :minimum => 10 }
  validate :complete_time_cannot_be_in_the_past, :complete_time_cannot_be_in_too_far_awary
    
  def complete_time_cannot_be_in_the_past
    errors.add(:complete_time, "can't be in the past") if self.new_record? and !complete_time.blank? and complete_time.to_date < Date.today
  end

  def complete_time_cannot_be_in_too_far_awary
    errors.add(:complete_time, "can't be too far away in future.") if self.new_record? and !complete_time.blank? and complete_time > 24.months.from_now
  end


  # return a list of locations for current projects
  def self.get_all_locations
    return Project.select('location').group("location")
  end

  # deliver project result to all supporter
  def deliver_project_result
    users = self.supporters
    users.each do |user|
      UserMailer.delay.project_result(user,self,self.name,self.owner.name)
    end
  end
end
