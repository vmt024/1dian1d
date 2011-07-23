class ProjectsController < ApplicationController
  layout 'diandi'

  before_filter :require_user, :only=>[:new,:edit,:destroy,:support_this_project,:not_support_this_project]


  # GET /projects
  # GET /projects.xml
  def welcome
    @projects = Project.current_projects.paginate(:all,:page=>params[:page],:order=>"rand()")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end


  # GET /projects
  # GET /projects.xml
  def index
    if !params[:category].blank?
      category_id = Category.find_by_name(params[:category]).id
      @projects = Project.paginate(:all,:conditions=>["category_id = ?",category_id],:order=>"name Asc",:page=>params[:page])
    elsif !params[:search_by].blank?
      case params[:search_by]
      when "热门目标"
        @projects = Project.paginate(:all,:order=>"views Desc",:page=>params[:page])
      when "过去的目标"
        @projects = Project.past_projects.paginate(:all,:order=>"rand()",:page=>params[:page])
      when "最新目标"
        @projects = Project.paginate(:all,:order=>"created_at Desc",:page=>params[:page])
      else
        @projects = Project.paginate(:all,:order=>"name Asc",:page=>params[:page])
      end
    elsif !params[:location].blank?
      @projects = Project.paginate(:all,:conditions=>["location = ?",params[:location]],:order=>"name Asc",:page=>params[:page])
    elsif !params[:support_by].blank?
      @projects = User.find(params[:support_by]).support_projects.paginate(:page=>params[:page])
    else
      @projects = Project.paginate(:all,:order=>"name Asc",:page=>params[:page])
    end


    respond_to do |format|
      format.html { render :action=>"welcome"}
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects
  # GET /projects.xml
  def search

    unless params[:search].blank?
      @projects = Project.paginate(:all,:conditions=>["name like ?","%#{params[:search]}%"],:order=>"name Asc",:page=>params[:page])
    else
      @projects = Project.paginate.all(:page=>params[:page])
    end
    render :action=> "welcome"
  end

  def recent_updated_followed
    @projects = Project.paginate(:all,:conditions=>["id in (#{session[:followed_progress].join(',')})"],:order=>"name Asc",:page=>params[:page])
    render :action=> "welcome"
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    session[:current_project_id] = params[:id]
    @project = Project.find(params[:id])
    @project.views += 1
    @project.save(false)
    project_list = Project.where("category_id = ? and id != ?",@project.category_id,@project.id).select('id').collect{|p| p.id}
    unless project_list.blank?
      @similar_projects = Project.where("id in (#{project_list.shuffle.first(9).join(",")})")
    else
      @similar_projects = []
    end
    session[:closed_projects].delete(@project.id) if !session[:closed_projects].blank? && session[:closed_projects].include?(@project.id)
    session[:new_progress].delete(@project.id) if !session[:new_progress].blank? && session[:new_progress].include?(@project.id)
    session[:followed_progress].delete(@project.id) if !session[:followed_progress].blank? && session[:followed_progress].include?(@project.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  def supporters
    @project = Project.find(params[:project_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  def comments
    @project = Project.find(params[:project_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  def progress
    @project = Project.find(params[:project_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    @project.user_id = session[:current_user_id]
    @project.views = 0
    @project.location = User.find(session[:current_user_id]).location

    respond_to do |format|

      if @project.save!
        unless params[:reward_conditions].blank? || params[:rewards].blank?
          for i in 0 .. params[:reward_conditions].size do 
            reward = ProjectPrize.new({:name=>params[:reward_conditions][i],:description=>params[:rewards][i]})
            reward.project_id = @project.id
            reward.save
          end
        end

        format.html { redirect_to project_url(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end

  def list_supporters
    @project = Project.find(session[:current_project_id])
  end

  def support_this_project
      support = UserProject.new
      support.project_id = params[:project_id]
      support.user_id = session[:current_user_id]
      support.save
      project = Project.find(params[:project_id])
      project.number_of_supporters += 1
      project.save
    respond_to do |format|
      format.html{redirect_to project_url(params[:project_id])}
      format.js 
    end
  end

  def not_support_this_project
      support = UserProject.where("project_id = ? and user_id = ?", params[:project_id],session[:current_user_id]).first
      support.destroy unless support.blank? 
      session[:followed_progress].delete(params[:project_id]) unless session[:followed_progress].blank?
      @project = Project.find(params[:project_id])
      @project.number_of_supporters -= 1
      @project.save
      @user = User.find(session[:current_user_id])

    respond_to do |format|
      format.html {redirect_to :back} 
      format.js
    end
  end

  def set_project_success
    @project = Project.find(params[:project_id])
    @project.success_yn = true
    @project.save
    respond_to do |format|
      format.js
    end
  end

  def set_project_fail
    @project = Project.find(params[:project_id])
    @project.success_yn = false
    @project.save
    respond_to do |format|
      format.js
    end
  end

  def more_rewards
    respond_to do |format|
      format.js
    end
  end
end

