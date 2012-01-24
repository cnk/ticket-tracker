class TicketsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_project
  before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]
  before_filter :authorize_create!, :only => [:new, :create]
  before_filter :authorize_update!, :only => [:edit, :update]
  before_filter :authorize_delete!, :only => [:destroy]

  # GET /projects/1/tickets/1
  # GET /projects/1/tickets/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @ticket }
    end
  end

  # GET /projects/1/tickets/new
  # GET /projects/1/tickets/new,json
  def new
    @ticket = @project.tickets.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @project }
    end
  end

  # POST /projects/1/tickets
  # POST /projects/1/tickets.json
  def create
    @ticket = @project.tickets.build(params[:ticket])
    @ticket.user = current_user

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to [@project, @ticket], :notice => 'Ticket has been created.' }
        format.json { render :json => @ticket, :status => :created, :location => [@project, @ticket] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /projects/1/tickets/1/edit
  def edit
  end

  # PUT /projects/1/tickets/1
  # PUT /projects/1/tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to [@project, @ticket], :notice => 'Ticket has been updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1/tickets/1
  # DELETE /projects/1/tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to project_url(@project), :notice => 'Ticket has been deleted.' }
      format.json { head :ok }
    end
  end


private

  def find_project
    begin
      @project = Project.for(current_user).find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for cannot be found."
      redirect_to root_path
    end
  end

  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def authorize_create!
    if !current_user.admin? && cannot?("create tickets".to_sym, @project)
      flash[:alert] = "You cannot create tickets on this project."
      redirect_to(project_path(@project))
    end
  end

  def authorize_update!
    if !current_user.admin? && cannot?("edit tickets".to_sym, @project)
      flash[:alert] = "You cannot edit tickets on this project."
      redirect_to(project_path(@project))
    end
  end

  def authorize_delete!
    if !current_user.admin? && cannot?("delete tickets".to_sym, @project)
      flash[:alert] = "You cannot delete tickets on this project."
      redirect_to(project_path(@project))
    end
  end
end
