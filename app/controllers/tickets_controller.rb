class TicketsController < ApplicationController
  before_filter :find_project
  before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(params[:ticket])

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

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  end
end
