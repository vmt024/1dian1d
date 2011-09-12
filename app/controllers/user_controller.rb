class UserController < ApplicationController
  layout 'diandi'

  before_filter :require_user, :only=>[:edit,:update,:add_friend, :delete_friend]

  def signup
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.superman = "NO"
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to user_url(@user)
    else
      render :action=>:signup
    end
  end

  def show
    calculate_notification if session[:current_user_id].eql?(params[:id].to_i)
    @user = User.find(params[:id])
    @projects = Project.where('user_id = ?',@user.id).order("updated_at DESC").paginate :per_page=>20, :page=>params[:page]
    unless session[:followed_fans].blank? || @user.id.eql?(session[:current_user_id])
      session[:followed_fans].delete(@user.id)  
    end
  end

  def calculate_notification
    unless session[:current_user_id].blank?
      @user = User.find(session[:current_user_id])
      session[:followed_progress] = recalculate_notification(@user.followed_progress,session[:followed_progress])
      session[:followed_fans] = recalculate_notification(@user.followed_fans,session[:followed_fans])
      session[:followers_new_goal] = recalculate_notification(@user.followers_new_goal,session[:followers_new_goal])
      session[:new_progress] = recalculate_new_progress(@user.new_progress)
      session[:closed_projects] = recalculate_notification(@user.closed_projects,session[:closed_projects])
      @user.last_notification_time = Time.now
      @user.save(:validate=>false)
    end
  end

  def recalculate_notification(unread,previous)
    previous ||= []
    unread ||= []
    return (previous + unread).uniq
  end

  def recalculate_new_progress(unread)
    return session[:new_progress] if unread.blank?

    unless session[:new_progress].blank?
      unread.each_key do |k|
        unread[k][:comment_counts] += session[:new_progress][k][:comment_counts] if session[:new_progress].has_key?(k)
        unread[k][:follower_counts] += session[:new_progress][k][:follower_counts] if session[:new_progress].has_key?(k)
      end
    end
    return unread 
  end

  def messages
    @user = User.find(params[:user_id])
    @messages = Message.my_private_messages(params[:user_id])
    respond_to do |format|
      format.js
    end
  end

  def friends
    @user = User.find(params[:user_id])
    @friends = Friend.my_friends(params[:user_id]).paginate :per_page=>20, :page=>params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def fans
    @user = User.find(params[:user_id])
    @fans = Friend.my_fans(params[:user_id]).paginate :per_page=>20, :page=>params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end


#  def projects
#    @user = User.find(params[:user_id])
#    @projects = Project.where('user_id = ?',params[:user_id]).order("updated_at DESC").paginate :per_page=>20, :page=>params[:page]
#    respond_to do |format|
#      format.html
#      format.js
#    end
#  end

  def supported_goals
    @user = User.find(params[:user_id])
    @projects = @user.support_projects.paginate :per_page=>20, :page=>params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @user = User.find(session[:current_user_id])
  end

  def update
    @user = User.find(session[:current_user_id])
    unless params[:user][:password].blank?
      @user.password_confirmation = params[:user][:password]
      @user.password = params[:user][:password]
    end

    @user.description = params[:user][:description]
    @user.location = params[:user][:location]
    if @user.save
      flash[:notice] = "修改成功"
      redirect_to :back
    else
      render :action => :edit
    end
  end

  def lost_password
  end

  def password_recover

    if User.exists?(["email = ?",params[:user][:email]])
      user = User.find_by_email(params[:user][:email])
      user.reset_password
      new_password = user.password
      if user.save
        UserMailer.delay.password_recover(user,new_password)
      else
        logger.error("User does not exist in the system.")
      end
    else
      logger.error("User does not exist in the system.")
    end
    flash[:notice] ="新的密码已经发送到您的邮箱里了"
    redirect_to :back
  end

  def add_friend
    Friend.add_as_my_friend(session[:current_user_id],params[:user_id])
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html {redirect_to user_url(params[:user_id])} 
      format.js 
    end
  end

  def delete_friend
    Friend.delete_my_friend(session[:current_user_id],params[:user_id])
    @friends_count = Friend.my_friends(session[:current_user_id]) 
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html {redirect_to user_url(params[:user_id])} 
      format.js 
    end
  end

  def validate_name
    @already_exists = User.exists?(["name = ?",params[:name]])
    respond_to do |format|
      format.js 
    end
  end

  def validate_email
    @already_exists = User.exists?(["email = ?",params[:email]])
    respond_to do |format|
      format.js
    end
  end
end

