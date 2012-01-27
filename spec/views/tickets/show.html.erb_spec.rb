require 'spec_helper'

describe "tickets/show.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :name => "My Project"))
    @ticket = assign(:ticket, stub_model(Ticket, :title => "Ticket title", :description => "Problem", 
                                         :user => stub_model(User, :id => 1, :email => "someone@example.com")))
  end

  shared_examples_for "ticket detail page" do
    it "displays the project name" do
      rendered.should match(/My Project/)
    end
    
    it "displays the ticket title" do
      rendered.should match(/Ticket title/)
    end

    it "displays a link to the ticket's project" do
      rendered.should have_selector "a", {:text => "My Project", :attributes => {:href => /\/projects\/\d/}}
    end

    it "displays a link to all projects" do
      assert_select "a", {:text => "All Projects", :attributes => {:href => /\/projects/}}
    end
  end

  context "logged in as an admin" do
    before(:each) do
      user = stub('User', :admin? => true)
      view.stub(:current_user).and_return(user)
      render
    end
    
    it_behaves_like "ticket detail page"
    
    it "displays an edit link" do
      rendered.should have_selector "a", {:text => "Edit", :attributes => {:href => /\/projects\/\d\/tickets\/\d\/edit/}}
    end
    
    it "displays a link to create a new ticket" do
      rendered.should have_selector "a", {:text => "New Ticket", :attributes => {:href => /\/projects\/\d\/tickets\/new/}}
    end
    
    it "displays a delete link" do
      rendered.should have_selector "a[data-method=delete]", :text => "Delete"
    end
  end

  context "logged in as a user with minimal permissions" do
    before(:each) do
      user = stub('User', :admin? => false)
      view.stub(:current_user).and_return(user)
      view.stub(:can?).with("create tickets".to_sym, @project).and_return(false)
      view.stub(:can?).with("edit tickets".to_sym, @project).and_return(false)
      view.stub(:can?).with("delete tickets".to_sym, @project).and_return(false)
      render
    end
    
    it_behaves_like "ticket detail page"
    
    it "does not display an edit link" do
      rendered.should_not have_selector "a", {:text => "Edit", :attributes => {:href => /\/projects\/\d\/tickets\/\d\/edit/}}
    end
    
    it "does not display a link to create a new ticket" do
      rendered.should_not have_selector "a", {:text => "New Ticket", :attributes => {:href => /\/projects\/\d\/tickets\/new/}}
    end
    
    it "does not display a delete link" do
      rendered.should_not have_selector "a[data-method=delete]", :text => "Delete"
    end
  end

  context "logged in as a user who can create tickets" do
    before(:each) do
      user = stub('User', :admin? => false)
      view.stub(:current_user).and_return(user)
      view.stub(:can?).with("create tickets".to_sym, @project).and_return(true)
      view.stub(:can?).with("edit tickets".to_sym, @project).and_return(false)
      view.stub(:can?).with("delete tickets".to_sym, @project).and_return(false)
      render
    end
    
    it_behaves_like "ticket detail page"
    
    it "displays a link to create a new ticket" do
      rendered.should have_selector "a", {:text => "New Ticket", :attributes => {:href => /\/projects\/\d\/tickets\/new/}}
    end
  end

  context "logged in as a user who can edit tickets" do
    before(:each) do
      user = stub('User', :admin? => false)
      view.stub(:current_user).and_return(user)
      view.stub(:can?).with("create tickets".to_sym, @project).and_return(false)
      view.stub(:can?).with("edit tickets".to_sym, @project).and_return(true)
      view.stub(:can?).with("delete tickets".to_sym, @project).and_return(false)
      render
    end
    
    it_behaves_like "ticket detail page"
    
    it "displays a link to edit the ticket" do
      rendered.should have_selector "a", {:text => "Edit", :attributes => {:href => /\/projects\/\d\/tickets\/\d\/edit/}}
    end
  end

  context "logged in as a user who can delete tickets" do
    before(:each) do
      user = stub('User', :admin? => false)
      view.stub(:current_user).and_return(user)
      view.stub(:can?).with("create tickets".to_sym, @project).and_return(false)
      view.stub(:can?).with("edit tickets".to_sym, @project).and_return(false)
      view.stub(:can?).with("delete tickets".to_sym, @project).and_return(true)
      render
    end
    
    it_behaves_like "ticket detail page"
    
    it "displays a delete link" do
      rendered.should have_selector "a[data-method=delete]", :text => "Delete"
    end
  end
end
