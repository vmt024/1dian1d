class UserObserver < ActiveRecord::Observer 

  # send email after registered new user
  def after_create(user) 
    UserMailer.delay.welcome_email(user)
  end
end
