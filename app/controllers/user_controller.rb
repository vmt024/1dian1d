class UserController < ApplicationController
  layout 'diandi'

  before_filter :require_user, :only=>[:edit,:update]

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
    if params[:section].blank? || params[:sort_by].blank?
      session[:sort_project_by] = "name"
    elsif params[:sort_by].eql?("项目名称")
      session[:sort_project_by] = "name"
    elsif params[:sort_by].eql?("支持人数")
      session[:sort_project_by] = "number_of_supporters"
    elsif params[:sort_by].eql?("剩余时间")
      session[:sort_project_by] = "complete_time"
    elsif params[:sort_by].eql?("浏览次数")
      session[:sort_project_by] = "views"
    end

    session[:sort_order] = session[:sort_order].blank? || session[:sort_order].eql?("Desc") ? "Asc" : "Desc"

    order = "#{session[:sort_project_by]} #{session[:sort_order]}"
    @user = User.find(params[:id])
    @my_private_messages = Message.my_private_messages(@user.id,:unread_only=>true)
    @my_friends = Friend.my_friends(@user.id) 
    @my_projects = Project.where('user_id = ?',@user.id).order(order)
    @my_support_projects = @user.support_projects.all(:order=>order)

    if !params[:section].blank? && params[:section].eql?("创建项目")
      @my_projects = Project.where('user_id = ?',@user.id).order(order)
    end

    if !params[:section].blank? && params[:section].eql?("关注项目")
      @my_support_projects = @user.support_projects.all(:order=>order)
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
      redirect_to user_url(@user)
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
    redirect_to :back
  end

  def send_friend_request
    Friend.add_as_my_friend(session[:current_user_id],params[:user_id])
    redirect_to :back
  end

end

