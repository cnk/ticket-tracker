require 'spec_helper'

describe TicketsController do
  before(:all) do
    @project = FactoryGirl.create(:project)
    @user = FactoryGirl.create(:user)
    Permission.create(:user => @user, :thing => @project, :action => 'view')
    @unprivileged_user = FactoryGirl.create(:user)
  end

  after(:all) do
    @project.destroy
    @user.destroy
    @unprivileged_user.destroy
  end

  context "a user without permissions on the parent project" do
    before(:each) do
      sign_in @unprivileged_user
      @ticket = FactoryGirl.create(:ticket, :project => @project)
    end

    describe "may not access any actions on the project's tickets" do
      {"new" => "get", "create" => "put", "edit" => "get", "update" => "post", "destroy" => "delete"}.each do |action, method|
        it "can't access the #{action} ticket action" do
          send(method, action, :project_id => @project.id, :id => @ticket.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql("The project you were looking for cannot be found.")
        end
      end
    end
  end

  context "a user with permission to only view the parent project" do
    before(:each) do
      sign_in @user
    end

    def cannot_create_tickets
      response.should redirect_to(project_path(@project))
      flash[:alert].should eql("You cannot create tickets on this project.")
    end

    it "cannot access the ticket creation form" do
      get :new, :project_id => @project.id
      cannot_create_tickets
    end

    it "cannot access the ticket creation action" do
      post :create, :project_id => @project.id
      cannot_create_tickets
    end
  end

  context "a user with permission to create tickets in the project" do
    before(:each) do
      Permission.create(:user => @user, :thing => @project, :action => 'create tickets')
      sign_in @user
    end

    it "can access the ticket creation form" do
      get :new, :project_id => @project.id
      response.should render_template("new")
    end

    it "can create a ticket" do
      post :create, :project_id => @project.id, :ticket => FactoryGirl.attributes_for(:ticket)
      flash[:notice].should eql("Ticket has been created.")
    end
  end

end
