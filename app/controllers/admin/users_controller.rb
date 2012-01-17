class Admin::UsersController < Admin::BaseController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_users_path, :notice => "User has been created."
    else
      flash[:alert] = "User has not been created."
      render :action => "new"
    end
  end
    
end
