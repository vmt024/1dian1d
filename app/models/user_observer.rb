class UserObserver < ActiveRecord::Observer 

  # send email after registered new user
  def after_create(user) 
    UserMailer.welcome_email(user).deliver 
  end
end
