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
      it "does not render the block that is passed in" do
        user = stub('User', :admin? => false)
        helper.stub(:current_user).and_return(user)
        content = helper.admins_only {"Set of admin links"}
        content.should be_blank
      end
    end
  end

  describe "#authorized?" do
    context "when the current user is an admin" do
      it "renders the block that is passed in" do
        thing = stub('Project')
        helper.stub(:can?).and_return(false)
        user = stub('User', :admin? => true)
        helper.stub(:current_user).and_return(user)
        content = helper.authorized?('view', thing) {"Set of restricted links"}
        content.should == "Set of restricted links"
      end
    end

    context "when the current user is allowed to view" do
      it "renders the block that is passed in" do
        thing = stub('Project')
        helper.stub(:can?).and_return(true)
        user = stub('User', :admin? => false)
        helper.stub(:current_user).and_return(user)
        content = helper.authorized?('view', thing) {"Set of restricted links"}
        content.should == "Set of restricted links"
      end
    end

    context "when the current user is not allowed to view" do
      it "does not render the block that is passed in" do
        thing = stub('Project')
        helper.stub(:can?).and_return(false)
        user = stub('User', :admin? => false)
        helper.stub(:current_user).and_return(user)
        content = helper.authorized?('view', thing) {"Set of restricted links"}
        content.should be_blank
      end
    end
  end
end
