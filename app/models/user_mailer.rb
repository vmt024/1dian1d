class UserMailer < ActionMailer::Base
   default :from=>"1dian1di",:charset=>"UTF-8",:content_type => "text/html"
  #layout 'awesome'
  
  def welcome_email(user)
    @user = user
    @url = "http://www.1dian1di.com/"
    attachments.inline['ribbon.jpg'] = File.read(Rails.public_path + '/images/ribbon.jpg')
    attachments.inline['header-bg.jpg'] = File.read(Rails.public_path + '/images/header-bg.jpg')
    attachments.inline['line-break-2.jpg'] = File.read(Rails.public_path + '/images/line-break-2.jpg')
    attachments.inline['date-bg.jpg'] = File.read(Rails.public_path + '/images/date-bg.jpg')
    mail(:to => user.email,
         :subject => "会员注册成功，1点1滴欢迎您的加入",
         :date => Date.today,
         :reply_to => "1dian1di@1dian1di.com")
  end

  def password_recover(user,new_password)
    @user = user
    @new_password = new_password
    @url = "http://www.1dian1di.com/"
    attachments.inline['ribbon.jpg'] = File.read(Rails.public_path + '/images/ribbon.jpg')
    attachments.inline['header-bg.jpg'] = File.read(Rails.public_path + '/images/header-bg.jpg')
    attachments.inline['line-break-2.jpg'] = File.read(Rails.public_path + '/images/line-break-2.jpg')
    attachments.inline['date-bg.jpg'] = File.read(Rails.public_path + '/images/date-bg.jpg')
    mail(:to => user.email,
         :subject => "1点1滴已经为您更新了密码",
         :date => Date.today,
         :reply_to => "1dian1di@1dian1di.com")
  end

  def project_result(user,project,project_name,project_owner)
    @user = user
    @project = project
    @project_name = project.name
    @project_owner = project.owner.name
    @url = "http://www.1dian1di.com/"
    attachments.inline['ribbon.jpg'] = File.read(Rails.public_path + '/images/ribbon.jpg')
    attachments.inline['header-bg.jpg'] = File.read(Rails.public_path + '/images/header-bg.jpg')
    attachments.inline['line-break-2.jpg'] = File.read(Rails.public_path + '/images/line-break-2.jpg')
    attachments.inline['date-bg.jpg'] = File.read(Rails.public_path + '/images/date-bg.jpg')
    mail(:to => user.email,
         :subject => "感谢您对#{user.name}的目标：#{project.name}的支持",
         :date => Date.today,
         :reply_to => "peterpengnz@gmail.com")
  end
end
