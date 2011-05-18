class ProjectsController < ApplicationController
  layout 'qutou'

  before_filter :require_user, :only=>[:new,:create,:edit,:update,:destroy,:support_this_project,:not_support_this_project]


  # GET /projects
  # GET /projects.xml
  def welcome
    @projects = Project.paginate(:all,:page=>params[:page])

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
      when "热门"
        @projects = Project.paginate(:all,:order=>"views Desc",:page=>params[:page])
      when "推荐"
        @projects = Project.paginate(:all,:order=>"number_of_supporters Desc",:page=>params[:page])
      when "最新"
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
    #render :action=> "index"
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    session[:current_project_id] = params[:id]
    @project = Project.find(params[:id])
    @project.views += 1
    @project.save(false)
    project_list = Project.where("category_id = ? and id != ?",@project.category_id,@project.id).select('id').collect{|p| p.id}
    @similar_projects = Project.where("id in (?)",project_list.shuffle.first(2).join(","))

    session[:new_progress].delete(@project.id) if !session[:new_progress].blank? && session[:new_progress].include?(@project.id)
    session[:followed_progress].delete(@project.id) if !session[:followed_progress].blank? && session[:followed_progress].include?(@project.id)

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
      if @project.save
        (1..8).each do |i|
          unless params[:reward_conditions]["#{i}"].blank? || params[:rewards]["#{i}"].blank?
          reward = ProjectPrize.new({:name=>params[:reward_conditions]["#{i}"],:description=>params[:rewards]["#{i}"]})
          reward.project_id = @project.id
          reward.save
          end
        end
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
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
    unless session[:current_user_id].blank?
      support = UserProject.new
      support.project_id = session[:current_project_id]
      support.user_id = session[:current_user_id]
      support.save
      project = Project.find(session[:current_project_id])
      project.number_of_supporters += 1
      project.save
      redirect_to project_url(session[:current_project_id])
    else
      session[:back_url] = request.env["REQUEST_URI"]
      redirect_to new_user_session_url
    end
  end

  def not_support_this_project
    unless session[:current_user_id].blank?
      support = UserProject.where("project_id = ? and user_id = ?", params[:project_id],session[:current_user_id]).limit(1)
      support.destroy
      session[:followed_progress].delete(params[:project_id]) if session[:followed_progress].include?(params[:project_id])
      project = Project.find(params[:project_id])
      project.number_of_supporters -= 1
      project.save

      redirect_to :back
    else
      session[:back_url] = request.env["REQUEST_URI"]
      redirect_to new_user_session_url
    end
  end
end

