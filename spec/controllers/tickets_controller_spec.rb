require 'spec_helper'

describe TicketsController do
  before(:all) do
    @project = Factory.create(:project)
    @user = Factory.create(:user)
  end

  before(:each) do 
    sign_in @user
  end

  after(:all) do
    @project.destroy
    @user.destroy
  end

  def valid_attributes
    {:title => "Ticket title", 
     :description => "Ticket description in all its glory.", 
     :project_id => @project.id}
  end

  describe "GET show" do
    before(:each) do
      @ticket = Ticket.create!(valid_attributes)
      get :show, :project_id => @project.id, :id => @ticket.id
    end

    it "assigns the project for the requested ticket as @project" do
      assigns(:project).should eq(@project)
    end

    it "assigns the requested ticket as @ticket" do
      assigns(:ticket).should eq(@ticket)
    end
  end

  describe "GET 'new'" do
    before(:each) do
      get :new, :project_id => @project.id
    end
    
    it "create a new ticket instance and assign it to the project" do
      assigns(:ticket).should be_a_new(Ticket)
      assigns(:ticket).project_id.should == @project.id
    end

    it "should set a project variable" do
      assigns(:project).should == @project
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Ticket" do
        expect {
          post :create, :project_id => @project.id, :ticket => valid_attributes
        }.to change(Ticket, :count).by(1)
      end

      it "redirects to the created ticket" do
        post :create, :project_id => @project.id, :ticket => valid_attributes
        response.should redirect_to([@project, assigns(:ticket)])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ticket as @ticket" do
        # Trigger the behavior that occurs when invalid params are submitted
        Ticket.any_instance.stub(:save).and_return(false)
        post :create, :project_id => @project.id, :ticket => {}
        assigns(:ticket).should be_a_new(Ticket)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Ticket.any_instance.stub(:save).and_return(false)
        post :create, :project_id => @project.id, :ticket => {}
        response.should render_template("new")
      end
    end
  end

  describe "GET 'edit'" do
    it "should retrieve the existing ticket information" do
      @ticket = Ticket.create!(valid_attributes)
      get :edit, :project_id => @project.id, :id => @ticket.id 
      assigns(:ticket).should == @ticket
    end
  end

  describe "PUT update" do
    before(:each) do
      @ticket = Ticket.create!(valid_attributes)
    end

    describe "with valid params" do
      it "updates the ticket information" do
        @ticket.title.should == valid_attributes[:title]
        put :update, :id => @ticket.id, :project_id => @project.id, :ticket => {:title => "New name", :description => "New description"}
        Ticket.find(@ticket.id).title.should == "New name"
      end

      it "redirects to the updated ticket" do
        put :update, :id => @ticket.id, :project_id => @project.id, :ticket => {:title => "New name", :description => "New description"}
        response.should redirect_to([@project, assigns(:ticket)])
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        put :update, :id => @ticket.id, :project_id => @project.id, :ticket => {:title => "", :description => ""}
        response.should render_template("edit")
      end
    end
  end

end
