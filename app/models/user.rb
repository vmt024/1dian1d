require 'digest'

class User < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :large => "48x48#", :medium => "36x36#", :small => "16x16#" }
  has_many :user_projects
  has_many :support_projects, :through=>:user_projects, :source=>:project
  has_many :my_projects, :class_name=>'Project'
  before_create :validate_password
  before_save :encrypt_password
  has_many :comments
  has_many :friends
  has_many :fans, :class_name=>"Friend",:foreign_key=>:friend_id

  attr_protected :superman, :crypted_password, :password_salt, :created_at, :updated_at, :last_login_time, :current_login_time

  attr_accessor :password, :password_confirmation, :remember_me
  validates_uniqueness_of :email
  validates_presence_of :name,:email

 # def to_param 
 #   name
 # end


  # check the crypted  password
    def correct_password?(submitted_password)
      if Rails.env.development?
        logger.error("cr: #{self.crypted_password}") 
        logger.error("ps: #{encrypt(submitted_password)}")
      end
      self.crypted_password == encrypt(submitted_password)
    end
 
  # check stored sign in cookies
    def self.sign_in_with_cookies(remember_cookie)
      return nil if remember_cookie.blank?
      cookie = Encryptor.decrypt(remember_cookie)
      email = cookie.split('--A--')[0]
      password_salt = cookie.split('--A--')[1]
      user = User.find_by_email(email)
      if (!user.blank? && user.password_salt == password_salt)
        user.last_login_time = user.current_login_time
        user.current_login_time = Time.now
        session[:followed_progress] = user.followed_progress
        session[:followed_fans] = user.followed_fans
        session[:new_progress] = user.new_progress
        session[:followers_new_goal] = user.followers_new_goal
        session[:closed_projects] = user.closed_projects
        user.last_notification_time = Time.now
        user.save
        return user.id 
      else
        return nil
      end
    end

    # auto reset password for user
    def reset_password
      new_password = secure_hash("#{self.email}==#{Time.now}==recover_password").first(6).upcase
      if Rails.env.development?
        logger.error("NEW PASSWORD::::::::::::::::: #{new_password}")
      end 
      self.password = new_password
      self.password_confirmation = new_password
    end
    # return a list of user id which is fans for current login user 
    # return [] if no fans 
    def followed_fans
      list = []
      fans = self.fans.where("created_at > ?",self.last_notification_time)
      fans.collect{|f| list << f.user_id.to_i unless list.include?(f.user_id.to_i)}
      return list
    end

    # return a list of closed projects for current login user 
    # return [] if no closed projects
    def closed_projects 
      list = []
      projects = self.my_projects.where("success_yn is null and complete_time < NOW()")
      projects.collect{|p| list << p.id.to_i unless list.include?(p.id.to_i)}
      return list
    end

    # return a list of project id which has new update since last login
    # return [] if no updates since last_login_time
    def followed_progress
      list = []
      projects = self.support_projects.includes(:project_updates).where("project_updates.created_at > ?",self.last_notification_time)
      projects.collect{|p| list << p.id.to_i unless list.include?(p.id.to_i)}
      return list
    end

    # return a list of goal id which is created by the person who current user followed 
    # return [] if no goal
    def followers_new_goal
      list = []
      friend_list = self.friends.collect{|f| f.friend_id}
      supported_goal_list = self.support_projects.collect{|s| s.id}
      unless friend_list.blank? 
        if supported_goal_list.blank?
          list = Project.where("user_id in (#{friend_list.join(',')}) and success_yn is null and created_at > ?",self.last_notification_time).collect{|n| n.id}
        else
          list = Project.where("id not in (#{supported_goal_list.join(',')}) and user_id in (#{friend_list.join(',')}) and success_yn is null and created_at > ?", self.last_notification_time).collect{|n| n.id}
        end
      end
      return list.sort
    end

    # return a list of project id which has new supporters and comments since last login
    # return format: {project_id=>{:comment_counts=>5,:follower_counts=>10}}
    def new_progress
      new_progress = {}
      own_projects = Project.where("user_id = ?",self.id).select('id')
      own_projects.each do |project|
        comment_counts = Comment.count(:conditions=>["project_id = ? and created_at > ? and user_id != ?",project.id,self.last_notification_time,self.id])
        follower_counts = UserProject.count(:conditions=>["project_id = ? and created_at > ?",project.id,self.last_notification_time])
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
      return Friend.is_my_friend?(self.id,my_user_id)
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

