module ProjectsHelper
  def highlight_this?(name)
    return params[:action].eql?(name) ? "currentNavigationalItem" : ""
  end
end
