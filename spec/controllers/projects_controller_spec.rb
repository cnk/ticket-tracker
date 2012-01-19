require 'spec_helper'

describe ProjectsController do
  before(:each) do
    @project =  FactoryGirl.create(:project)
  end

  let(:user) do
    user = FactoryGirl.create(:user)
  end

  let(:admin) do
    user = FactoryGirl.create(:admin)
  end

  context "no user (not signed in)" do
    describe "can see the index page" do
      it "assigns all projects as @projects" do
        get :index
        assigns(:projects).should eq([@project])
      end
    end

    it "can not see the details page without logging in" do
      get :show, :id => @project.id
      response.should redirect_to(new_user_session_path)
    end
  end

  context "standard users" do
    before(:each) do
     sign_in(:user, user)
    end

    describe "can see the index page" do
      it "assigns all projects as @projects" do
        get :index
        assigns(:projects).should eq([@project])
      end
    end

    it "can not see the details page for a general project" do
      get :show, :id => @project.id
      response.should redirect_to(projects_path)
      flash[:alert].should == "The project you were looking for cannot be found."
    end

    it "displays an error when going to the details page for a non-existant project" do
      get :show, :id => 0
      response.should redirect_to(projects_path)
      flash[:alert].should == "The project you were looking for cannot be found."
    end

    describe "can see the details page for a project it has permission for" do
      before(:each) do
        @myproject = FactoryGirl.create(:project)
        Permission.create!(:user => user, :thing => @myproject, :action => 'view')
        get :show, :id => @myproject.id
      end

      it "assigns the requested project as @project" do
        assigns(:project).should eq(@myproject)
      end

      it "displays the tickets for this project" do
        assigns(:tickets).should eq(@myproject.tickets)
      end

      it "does not show an edit link" do
        response.body.should_not have_link("Edit")
      end

      it "does not show a delete link" do
        response.body.should_not have_link("Delete")
      end
    end

    describe "cannot perform certain administrative actions" do
      # loop over restricted actions
      {"new" => "get", "create" => "put", "edit" => "get", "update" => "post", "destroy" => "delete"}.each do |action, method|
        it "can't access the #{action} project action" do
          project = mock_model(Project)
          Project.stub(:find).and_return(project)
          send(method, action, :id => project.id)
          response.should redirect_to(projects_path)
          flash[:alert].should eql('You must be an admin to do that.')
        end
      end
    end
  end

  context "admin users" do
    before(:each) do
      sign_in(:user, admin)
    end
    
    describe "can see the details page" do
      before(:each) do
        get :show, :id => @project.id
      end

      it "assigns the requested project as @project" do
        assigns(:project).should eq(@project)
      end

      it "displays the tickets for this project" do
        assigns(:tickets).should eq(@project.tickets)
      end

      it "displays an edit link" do
        response.body.should have_link("Edit", :href => "/projects/#{@project.id}/edit")
      end

      it "displays a delete link" do
        response.body.should have_link("Delete", :href => "/projects/#{@project.id}")
      end
    end

    describe "GET new" do
      it "assigns a new project as @project" do
        get :new
        assigns(:project).should be_a_new(Project)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Project" do
          expect {
            post :create, :project => FactoryGirl.attributes_for(:project)
          }.to change(Project, :count).by(1)
        end

        it "assigns a newly created project as @project" do
          post :create, :project => FactoryGirl.attributes_for(:project)
          assigns(:project).should be_a(Project)
          assigns(:project).should be_persisted
        end

        it "redirects to the created project" do
          post :create, :project => FactoryGirl.attributes_for(:project)
          response.should redirect_to(Project.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved project as @project" do
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          post :create, :project => {}
          assigns(:project).should be_a_new(Project)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          post :create, :project => {}
          response.should render_template("new")
        end
      end
    end

    describe "GET edit" do
      it "assigns the requested project as @project" do
        get :edit, :id => @project.id
        assigns(:project).should eq(@project)
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested project" do
          # Assuming there are no other projects in the database, this
          # specifies that the Project created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Project.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => @project.id, :project => {'these' => 'params'}
        end

        it "assigns the requested project as @project" do
          put :update, :id => @project.id, :project => FactoryGirl.attributes_for(:project)
          assigns(:project).should eq(@project)
        end

        it "redirects to the project" do
          put :update, :id => @project.id, :project => FactoryGirl.attributes_for(:project)
          response.should redirect_to(@project)
        end
      end

      describe "with invalid params" do
        it "assigns the project as @project" do
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          put :update, :id => @project.id, :project => {}
          assigns(:project).should eq(@project)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          put :update, :id => @project.id, :project => {}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested project" do
        expect {
          delete :destroy, :id => @project.id
        }.to change(Project, :count).by(-1)
      end

      it "redirects to the projects list" do
        delete :destroy, :id => @project.id
        response.should redirect_to(projects_url)
      end
    end
  end

end
