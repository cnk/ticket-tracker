class TicketsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_project
  before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]

  # GET /projects/1/tickets/1
  # GET /projects/1/tickets/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /projects/1/tickets/new
  # GET /projects/1/tickets/new,json
  def new
    @ticket = @project.tickets.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # POST /projects/1/tickets
  # POST /projects/1/tickets.json
  def create
    @ticket = @project.tickets.build(params[:ticket])
    @ticket.user = current_user

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to [@project, @ticket], notice: 'Ticket has been created.' }
        format.json { render json: @ticket, status: :created, location: [@project, @ticket] }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
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
        format.html { redirect_to [@project, @ticket], notice: 'Ticket has been updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1/tickets/1
  # DELETE /projects/1/tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to project_url(@project), notice: 'Ticket has been deleted.' }
      format.json { head :ok }
    end
  end


private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  end
end
