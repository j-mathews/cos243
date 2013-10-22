class UsersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:edit, :update, :index]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_admin_user, only: [:destroy]
	before_action :ensure_not_logged_in, only: [:new, :create]
  
  def index
    @users = User.all
  end
  
  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end
  
  def create
    @user = User.new(permittedparams)
    
    if @user.save then
      flash[:success] = "Welcome to the site: #{@user.username}"
			cookies[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit 
    @user = User.find(params[:id])
  end
    
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(permittedparams)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin?
      flash[:danger] = "Should not delete admin"
      redirect_to root_path
    elsif !current_user?(@user)
      @user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    else
      flash[:danger] = "Can't delete yourself."
      redirect_to root_path
    end      
  end
    
    
  private
    def permittedparams
      permittedparams = params.require(:user).permit(:username,:password,:password_confirmation,:email)
    end    
    
    def ensure_user_logged_in
      redirect_to login_path, flash: { :warning => "Unable" } unless logged_in?
    end
		
		def ensure_not_logged_in
      redirect_to root_path, flash: { :warning => "You are logged in and cannot perform that action!" } unless !logged_in?
    end 
    
    def ensure_correct_user
			@user = User.find(params[:id])
      redirect_to root_path, flash: { :danger => "Must be Logged in!" } unless current_user?(@user)
    end
    
    def ensure_admin_user
       redirect_to users_path unless current_user.admin?
    end
    
end
