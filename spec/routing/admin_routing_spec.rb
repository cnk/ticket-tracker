require "spec_helper"

describe "AdminController" do
  describe "routing" do

    it "routes to Admin::Base for the #index action" do
      get("/admin").should route_to("admin/base#index")
    end

  end
end
