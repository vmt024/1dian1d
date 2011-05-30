class UserMailer < ActionMailer::Base
   default :from=>"1dian1di",:charset=>"UTF-8",:content_type => "text/html"
  #layout 'awesome'
  
  def welcome_email(user)
    @user = user
    @url = "http://www.1dian1di.com/"
    mail(:to => user.email,
         :subject => "会员注册成功，一点一滴欢迎您的加入",
         :date => Date.today,
         :reply_to => "peterpengnz@gmail.com")
  end

  def password_recover(user)
    @user = user
    @url = "http://www.1dian1di.com/"
    mail(:to => user.email,
         :subject => "一点一滴已经为您更新了密码",
         :date => Date.today,
         :reply_to => "peterpengnz@gmail.com")
  end

end
