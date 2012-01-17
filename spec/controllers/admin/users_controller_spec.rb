require 'spec_helper'

describe Admin::UsersController do
  let(:user) do
    user = FactoryGirl.create(:user)
  end

  context "standard users" do
    before(:each) do
      sign_in(:user, user)
    end

    it "are not able to access the index action" do
      get 'index'
      response.should redirect_to(root_path)
      flash[:alert].should eq("You must be an admin to do that.")
    end
  end
end
