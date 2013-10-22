class SessionsController < ApplicationController
  def new
		@thereisanerror = false
  end
  
  def create
		@thereisanerror = false
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      cookies[:user_id] = @user.id
      flash[:success] = "#{@user.username} logged on."
      redirect_to @user
    else
			@thereisanerror = true
      flash.now[:danger] = "Invalid username or password"
      render 'new'
    end
  end
   
  def destroy
		logOut(@user)
    flash[:info] = "You have logged out!"
    redirect_to root_path
  end
end
