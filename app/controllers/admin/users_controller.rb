class Admin::UsersController < Admin::BaseController

  def index
    @users = User.find(:all)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.update_attribute(:admin, params[:user][:admin])

    if @user.save
      redirect_to admin_users_path, :notice => "User has been created."
    else
      flash[:alert] = "User has not been created."
      render :action => "new"
    end
  end
    
end
