require 'spec_helper'

describe "projects/show.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project, :name => "Name"))
    @tickets = [assign(:ticket, stub_model(Ticket, :title => "Ticket title", :description => "Problem"))]
  end

  context "when logged in as an admin" do
    before(:each) do
      user = stub('User', :admin? => true)
      view.stub(:current_user).and_return(user)
      render
    end

    it "displays the project name" do
      rendered.should match(/Name/)
    end
    
    it "displays the tickets for this project" do
      rendered.should have_selector "ol>li>a[href]", :text => "Ticket title"
    end
    
    it "displays a new ticket link" do
      rendered.should have_selector "a[href]", :text => "New Ticket"
    end
    
    it "displays an edit link" do
      rendered.should have_selector("a", {:text => "Edit", :attributes => {:href => /\/projects\/\d\/edit/}})
    end
    
    it "displays a delete link" do
      rendered.should have_selector( "a[data-method=delete]", :text => "Delete" )
    end
  end

  context "when logged in as a user with permission to add tickets to the project " do
    before(:each) do
      view.stub(:can?).with("create tickets".to_sym, @project).and_return(true)
      render
    end

    it "displays the project name" do
      rendered.should match(/Name/)
    end
    
    it "displays the tickets for this project" do
      rendered.should have_selector "ol>li>a[href]", :text => "Ticket title"
    end
    
    it "displays a new ticket link" do
      rendered.should have_selector "a[href]", :text => "New Ticket"
    end
    
    it "does not display an edit link" do
      rendered.should_not have_selector("a", {:text => "Edit", :attributes => {:href => /\/projects\/\d\/edit/}})
    end

    it "does not display a delete link" do
      rendered.should_not have_selector( "a[data-method=delete]", :text => "Delete" )
    end
  end

  context "when logged in as a user without permission to edit the project " do
    before(:each) do
      view.stub(:can?).with("create tickets".to_sym, @project).and_return(false)
      render
    end

    it "displays the project name" do
      rendered.should match(/Name/)
    end
    
    it "displays the tickets for this project" do
      rendered.should have_selector "ol>li>a[href]", :text => "Ticket title"
    end
    
    it "displays a new ticket link" do
      rendered.should_not have_selector "a[href]", :text => "New Ticket"
    end
    
    it "does not display an edit link" do
      rendered.should_not have_selector("a", {:text => "Edit", :attributes => {:href => /\/projects\/\d\/edit/}})
    end

    it "does not display a delete link" do
      rendered.should_not have_selector( "a[data-method=delete]", :text => "Delete" )
    end
  end

end
