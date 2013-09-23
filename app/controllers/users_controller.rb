class UsersController < ApplicationController
	
	def new
		@user = User.new
	end
	
	def create
    permitted_params = params.require(:user).permit(:username, :password, :password_confirmation)
    @user = User.new(permitted_params)
    @user.save
		#@user = User.new(:username => params[:username], :password => [:password])
		#render 'new'
	end
	
end
