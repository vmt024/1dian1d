class UserMailer < ActionMailer::Base
   default :from=>"趣目网",:charset=>"UTF-8",:content_type => "text/html"
  #layout 'awesome'
  
  def welcome_email(user)
    @user = user
    @url = "http://www.qutou.com/"
    mail(:to => user.email,
         :subject => "会员注册成功，趣投网欢迎您的加入",
         :date => Date.today,
         :reply_to => "peterpengnz@gmail.com")
  end

  def password_recover(user)
    @user = user
    @url = "http://www.qutou.com/"
    mail(:to => user.email,
         :subject => "趣投网已经为您更新了密码",
         :date => Date.today,
         :reply_to => "peterpengnz@gmail.com")
  end

end
