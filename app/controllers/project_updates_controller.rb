class ProjectUpdatesController < ApplicationController
  layout 'diandi'

  before_filter :require_user, :only=>[:new,:create,:edit,:update,:destroy]
  # GET /project_updates
  # GET /project_updates.xml
  def index
    project_id = session[:current_project_id] || params[:project_id]
    @project_updates = ProjectUpdate.all(:conditions=>['project_id = ?',project_id])
    @new_project_update = ProjectUpdate.new
    @project = Project.find(project_id)
    @new_update = Project.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_updates }
    end
  end

  # GET /project_updates/1
  # GET /project_updates/1.xml
  def show
    @project_update = ProjectUpdate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project_update }
    end
  end

  # GET /project_updates/new
  # GET /project_updates/new.xml
  def new
    @project_update = ProjectUpdate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_update }
    end
  end

  # GET /project_updates/1/edit
  def edit
    @project_update = ProjectUpdate.find(params[:id])
  end

  # POST /project_updates
  # POST /project_updates.xml
  def create
    @project_update = ProjectUpdate.new(params[:project_update])
    @project_update.project_id = session[:current_project_id]
    respond_to do |format|
      if @project_update.save
        format.html { redirect_to(project_url(session[:current_project_id],:selected_tab=>"project_update"), :notice => 'ProjectUpdate was successfully created.') }
        format.xml  { render :xml => @project_update, :status => :created, :location => @project_update }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project_update.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /project_updates/1
  # PUT /project_updates/1.xml
  def update
    @project_update = ProjectUpdate.find(params[:id])

    respond_to do |format|
      if @project_update.update_attributes(params[:project_update])
        format.html { redirect_to(@project_update, :notice => 'ProjectUpdate was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project_update.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /project_updates/1
  # DELETE /project_updates/1.xml
  def destroy
    @project_update = ProjectUpdate.find(params[:id])
    @project_update.destroy

    respond_to do |format|
      format.html { redirect_to(project_updates_url) }
      format.xml  { head :ok }
    end
  end
end
