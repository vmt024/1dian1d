class UserSessionController < ApplicationController
  layout 'diandi'

  before_filter :require_user, :only=>:destroy

  def new
    @user = User.new
  end

  def create

    if params[:user].blank? || params[:user][:email].blank? || params[:user][:password].blank?
      logger.error("Error 1")
      flash[:error] = 'Login failed! Empty value in email or password field. '
      redirect_to :back
    else
      @user = User.find_by_email(params[:user][:email])

      if !@user.blank? && @user.correct_password?(params[:user][:password])
        logger.error("Error 2")
        flash[:notice] = "Login successful!"
        @user.last_login_time = '2011-04-05 10:10:10'#@user.current_login_time
        @user.current_login_time = Time.now
        @user.save
        cookies[:remember_token] = Encryptor.encrypt(:value=>"#{@user.email}--A--#{@user.password_salt}") if params[:user][:remember_me].eql?('1')
        session[:followed_progress] = @user.followed_progress
        session[:new_progress] = @user.new_progress
        if @user.superman.eql?("YES")
          session[:is_superman] = true
        else
          session[:is_superman] = false
        end
        session[:current_user_id] = @user.id
        if session[:back_url].blank?
          redirect_to(:controller => :user, :action => :show, :id=>session[:current_user_id])
        else
          redirect_to session[:back_url]
        end
      else
        logger.error("Error 3  #{@user.blank?} #{params[:user][:password]}")
        flash[:error] = "Login failed! Wrong password or email address. "
        redirect_to sign_in_url
      end
    end
  end

  def destroy
    session[:is_superman] = nil
    session[:current_user_id] = nil
    session[:current_project_id] = nil
    session[:followed_progress] = nil
    session[:new_progress] = nil
    flash[:notice] = "Logout successful!"
    cookies.delete(:remember_token)
    redirect_to root_url
  end

end

