class ProjectPrizesController < ApplicationController

  before_filter :require_user, :only=>[:new,:create,:edit,:update,:destroy]

  layout 'diandi'

  # GET /project_prizes/new
  # GET /project_prizes/new.xml
  def new
    @project_prize = ProjectPrize.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_prize }
    end
  end

  # GET /project_prizes/1/edit
  def edit
    @project_prize = ProjectPrize.find(params[:id])
  end

  # POST /project_prizes
  # POST /project_prizes.xml
  def create
    @project_prize = ProjectPrize.new(params[:project_prize])
    @project_prize.project_id = session[:current_project_id]
    respond_to do |format|
      if @project_prize.save
        format.html { redirect_to(project_url(session[:current_project_id]), :notice => 'ProjectPrize was successfully created.') }
        format.xml  { render :xml => @project_prize, :status => :created, :location => @project_prize }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project_prize.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /project_prizes/1
  # PUT /project_prizes/1.xml
  def update
    @project_prize = ProjectPrize.find(params[:id])

    respond_to do |format|
      if @project_prize.update_attributes(params[:project_prize])
        format.html { redirect_to(@project_prize, :notice => 'ProjectPrize was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project_prize.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /project_prizes/1
  # DELETE /project_prizes/1.xml
  def destroy
    @project_prize = ProjectPrize.find(params[:id])
    @project_prize.destroy

    respond_to do |format|
      format.html { redirect_to(project_prizes_url) }
      format.xml  { head :ok }
    end
  end
end
