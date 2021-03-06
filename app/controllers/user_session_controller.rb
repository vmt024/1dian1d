class UserSessionController < ApplicationController
  
  layout 'diandi'

  def new
    @user = User.new
  end

  def create
    if params[:user].blank? || params[:user][:email].blank? || params[:user][:password].blank?
      flash[:notice] = '邮箱地址或者密码不正确。 '
      redirect_to :back
    else
      @user = User.find_by_email(params[:user][:email])

      if !@user.blank? && @user.correct_password?(params[:user][:password])
        @user.last_login_time = @user.current_login_time
        @user.current_login_time = Time.now
        @user.save
        if params[:user][:remember_me].eql?('1')
          cookies[:remember_token] = {
            :value => Encryptor.encrypt(:value=>"#{@user.email}--A--#{@user.password_salt}"), 
            :expires => 10.year.from_now,
            :domain => '1dian1di.com'
           }
        end
        if @user.superman.eql?("YES")
          session[:is_superman] = true
        else
          session[:is_superman] = false
        end
        session[:current_user_id] = @user.id
        redirect_back_or_default(user_url(session[:current_user_id]))
      else
        flash[:notice] = '邮箱地址或者密码不正确。 '
        redirect_to sign_in_url
      end
    end
  end

  def destroy
    reset_session
    cookies.delete(:remember_token)
    redirect_to root_url
  end

end

