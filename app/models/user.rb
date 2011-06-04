require 'digest'

class User < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "538x288#", :thumb => "220x144#" }
  has_many :user_projects
  has_many :support_projects, :through=>:user_projects, :source=>:project
  has_many :my_projects, :class_name=>'Project'
  before_create :validate_password
  before_save :encrypt_password
  has_many :comments
  has_many :friends

  attr_protected :superman

  attr_accessor :password, :password_confirmation, :remember_me
  validates_uniqueness_of :email
  validates_presence_of :name,:email

    def correct_password?(submitted_password)
      logger.error("cr: #{self.crypted_password}")
      logger.error("ps: #{encrypt(submitted_password)}")
      self.crypted_password == encrypt(submitted_password)
    end
 

    def self.sign_in_with_cookies(remember_cookie)
      return nil if remember_cookie.blank?
      cookie = Encryptor.decrypt(remember_cookie)
      email = cookie.split('--A--')[0]
      password_salt = cookie.split('--A--')[1]
      user = User.find_by_email(email)
      return (!user.blank? && user.password_salt == password_salt) ? user.id : nil
    end

    def reset_password
      new_password = secure_hash("#{self.email}==#{Time.now}==recover_password").first(8)
      logger.error("NEW PASSWORD::::::::::::::::: #{new_password}")
      self.password = new_password
      self.password_confirmation = new_password
    end

    # return a list of project id which has new update since last login
    # return [] if no updates since last_login_time
    def followed_progress
      list = []
#      projects = Project.find_by_sql("select up.project_id as project_id from user_projects as up left join project_updates as pu on up.project_id = pu.project_id where pu.created_at > '#{self.last_login_time}'")
      projects = self.support_projects.includes(:project_updates).where("project_updates.created_at > ?",self.last_login_time)
      projects.collect{|p| list << p.id.to_i unless list.include?(p.id.to_i)}
      return list
    end

    # return a list of project id which has new supporters and comments since last login
    # return format: {project_id=>{:comment_counts=>5,:follower_counts=>10}}
    def new_progress
      new_progress = {}
      own_projects = Project.where("user_id = ?",self.id).select('id')
      own_projects.each do |project|
        comment_counts = Comment.count(:conditions=>["project_id = ? and created_at > ?",project.id,self.last_login_time])
        follower_counts = UserProject.count(:conditions=>["project_id = ? and created_at > ?",project.id,self.last_login_time])
        unless comment_counts.eql?(0) && follower_counts.eql?(0)
          new_progress[project.id] = {:comment_counts=>comment_counts,:follower_counts=>follower_counts}
        end
      end
      return new_progress
    end

    def unread_message_count
      return Message.unread_message_count(self.id)
    end

    def received_messages
      return Message.messages_sent_to(self.id)
    end

    def sent_messages
      return Message.messages_sent_from(self.id)
    end

    def send_message_to(user_id,message)
      return Message.send_message(:from=>self.id,:to=>user_id,:content=>message)
    end

    def reply_message(message_id,reply)
      return Message.reply_to_this_message(:reply_to_id=>message_id,:content=>reply)
    end

    def is_my_friend?(my_user_id)
      return Friend.are_they_friend?(self.id,my_user_id)
    end

    def is_allowed_send_PM_to(friend_id)
      return Friend.are_they_friend_to_each_other?(self.id,friend_id)
    end

    private
    def encrypt_password
      self.password_salt = generate_salt if new_record?
      self.crypted_password = encrypt(password) unless password.blank?
      #self.persistence_taken = encrypt(confirm_password)
    end

    # convert plain text string to hash
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    # encrypt user password with salt
    def encrypt(password)
      secure_hash("#{self.password_salt}--#{password}")
    end

    # generate salt for user password encryption
    def generate_salt
      secure_hash("#{Time.now}--#{password}")
    end

    # check password and password confirmation are same
    def validate_password
      if self.password != self.password_confirmation
        self.errors.add('password_confirmation','password not match to confirm password')
       return false
      end
    end


end

