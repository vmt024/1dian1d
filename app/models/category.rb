class Category < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "538x288#", :thumb => "220x144#" }

  has_many :projects

end
