module ProjectsHelper
  def project_has_image?(avatar)
    return false if avatar.blank?
    return File.exist?(avatar.path(:medium))
  rescue=>e
    logger.error("Error:#{e}")
    return ""
  end

  def random_id_for_reward
    return "reward_#{ActiveSupport::SecureRandom.hex(2)}"
  end

  def already_voted?
    @goal = Project.find(session[:current_project_id])
    return @goal.voters.collect{|v| v.user_id}.include?(session[:current_user_id])
  rescue=>e
    logger.error("Error::application_helper::already_voted")
    logger.error(e)
    return false
  end

  def goal_owner?
    @goal = Project.find(session[:current_project_id])
    return @goal.user_id.eql?(session[:current_user_id])
  rescue=>e
    logger.error("Error::application_helper::goal_owner")
    logger.error(e)
    return false
  end

end
