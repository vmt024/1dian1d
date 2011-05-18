# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def user_is_project_owner?(user_id)
    return true if session[:current_user_id].eql?(user_id)
    return false
  end

  def action_allowed?
    return true if true.eql?(session[:is_superman])
    return false
  end

  def project_days_left(complete_time)
    days = complete_time.to_date - Time.now.to_date
    return days < 0 ? 0 : days
  end

  def province_list
   list = [['北京市'],
          ['天津市'],
          ['上海市'],
          ['重庆市'],
          ['香港特别行政区'],
          ['澳门特别行政区'],
          ['河北省'],
          ['山西省'],
          ['内蒙古自治区'],
          ['辽宁省'],
          ['吉林省'],
          ['黑龙江省'],
          ['江苏省'],
          ['浙江省'],
          ['安徽省'],
          ['福建省'],
          ['江西省'],
          ['山东省'],
          ['河南省'],
          ['湖北省'],
          ['湖南省'],
          ['广东省'],
          ['广西壮族自治区'],
          ['海南省'],
          ['四川省'],
          ['贵州省'],
          ['云南省'],
          ['西藏自治区'],
          ['陕西省'],
          ['甘肃省'],
          ['青海省'],
          ['宁夏回族自治区'],
          ['新疆维吾尔自治区'],
          ['台湾省'],['国外']]
    return list
  end

  def already_supported?
    UserProject.exists?(["project_id = ? and user_id = ?",session[:current_project_id],session[:current_user_id]])
  end
end
