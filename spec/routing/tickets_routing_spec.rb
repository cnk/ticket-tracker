require "spec_helper"

describe TicketsController do
  describe "routing" do

    it "has a nested route to #show" do
      get("/projects/3/tickets/1").should route_to("tickets#show", :project_id => "3", :id => "1")
    end

    it "has a nested route to #new" do
      get("/projects/1/tickets/new").should route_to("tickets#new", :project_id => "1")
    end

    it "has a nested route to #create" do
      post("/projects/1/tickets").should route_to("tickets#create", :project_id => "1")
    end

  end
end
