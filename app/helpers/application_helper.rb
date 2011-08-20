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
   list = [['北京'],
          ['天津'],
          ['上海'],
          ['重庆'],
          ['香港'],
          ['澳门'],
          ['河北'],
          ['山西'],
          ['内蒙古'],
          ['辽宁'],
          ['吉林'],
          ['黑龙江'],
          ['江苏'],
          ['浙江'],
          ['安徽'],
          ['福建'],
          ['江西'],
          ['山东'],
          ['河南'],
          ['湖北'],
          ['湖南'],
          ['广东'],
          ['广西'],
          ['海南'],
          ['四川'],
          ['贵州'],
          ['云南'],
          ['西藏'],
          ['陕西'],
          ['甘肃'],
          ['青海'],
          ['宁夏'],
          ['新疆'],
          ['台湾'],['国外']]
    return list
  end

  def already_supported?
    UserProject.exists?(["project_id = ? and user_id = ?",session[:current_project_id],session[:current_user_id]])
  rescue=>e
    logger.error("Error::application_helper::already_supported")
    logger.error(e)
    return false
  end

  def logged_in_user?
    return !session[:current_user_id].blank?
  end

end
