require 'spec_helper'

describe ApplicationHelper do
  describe "#admins_only" do
    context "when the current user is an admin" do
      it "renders the block that is passed in" do
        user = stub('User', :admin? => true)
        helper.stub(:current_user).and_return(user)
        content = helper.admins_only {"Set of admin links"}
        content.should == "Set of admin links"
      end
    end

    context "when the current user is NOT an admin" do
      it "renders the block that is passed in" do
        user = stub('User', :admin? => false)
        helper.stub(:current_user).and_return(user)
        content = helper.admins_only {"Set of admin links"}
        content.should be_blank
      end
    end
  end
end
