module ProjectsHelper
  def highlight_this?(name)
    return params[:action].eql?(name) ? "currentNavigationalItem" : ""
  rescue=>e
    logger.error("Error:#{e}")
    return ""
  end

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
end
