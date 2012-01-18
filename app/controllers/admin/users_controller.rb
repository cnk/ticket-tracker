class Admin::UsersController < Admin::BaseController

  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    # if we don't set a password, don't try to update it
    if params[:user][:password].blank?
       params[:user].delete(:password)
       params[:user].delete(:password_confirmation)
    end

    @user = User.find(params[:id])
    # Can't mass assign admin; update it first
    @user.admin = params[:user][:admin] 

    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, :notice => "User has been updated."
    else
      flash[:alert] = "User has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      flash[:alert] = "You cannot delete yourself!"
    else
      if @user.destroy
        flash[:notice] = "User has been deleted."
      else
        flash[:alert] = "User was not deleted."
      end
    end
    redirect_to admin_users_path
  end
    
end
