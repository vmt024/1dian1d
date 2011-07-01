# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user
  
  private

    def current_user
      session[:current_user_id] ||= User.sign_in_with_cookies(cookies[:remember_token])
      @current_user ||= User.find(session[:current_user_id]) unless session[:current_user_id].blank?
      return session[:current_user_id] 
    end
    
    def require_user
      if current_user.blank?
        store_location
        flash[:notice] = "您需要登录后才能继续。"
        redirect_to sign_in_url
        return false
      end
    end

    def require_superman
      return true if session[:is_superman]
      return false
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      if Rails.env.development?
        logger.error("return_to session: #{session[:return_to]}")
      end
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

end
