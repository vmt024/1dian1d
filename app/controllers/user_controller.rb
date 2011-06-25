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
      flash[:notice] = "Account registered!"
      session[:current_user_id] = @user.id
      redirect_to user_url(@user)
    else
      render :action=>:signup
    end
  end

  def show
    @user = User.find(params[:id])
    @projects = Project.where('user_id = ?',@user.id).order("updated_at DESC")
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
    @friends = Friend.my_friends(params[:user_id]) 
    respond_to do |format|
      format.js
    end
  end

  def fans
    @user = User.find(params[:user_id])
    @fans = Friend.my_fans(params[:user_id]) 
    respond_to do |format|
      format.js
    end
  end


  def projects
    @user = User.find(params[:user_id])
    @projects = Project.where('user_id = ?',params[:user_id]).order("updated_at DESC")
    respond_to do |format|
      format.js
    end
  end

  def supported_projects
    @user = User.find(params[:user_id])
    @projects = @user.support_projects
    respond_to do |format|
      format.js
    end
  end

  def edit
    @user = User.find(session[:current_user_id])
  end

  def update
    @user = User.find(session[:current_user_id])
    if !params[:user][:password].blank?
      params[:user][:password_confirmation] = params[:user][:password]
    end

    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to edit_user_url(@user)
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
      if user.save
        UserMailer.password_recover(user).deliver
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

