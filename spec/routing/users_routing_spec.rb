require "spec_helper"

describe UsersController do
  describe "routing" do

    it "has a route for the email confirmation page during registration" do
      get("/awaiting_confirmation").should route_to("users#confirmation")
    end

    it "should have a route named 'confirm_user' for the confirmation page" do
      get(confirm_user_path).should route_to(:controller => 'users', :action => 'confirmation')
    end

  end
end
