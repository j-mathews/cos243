class UsersController < ApplicationController
	
	def new
		@user = User.new
	end
	
	def create
		@user = User.new(:username => params[:username], :password => [:password])
		render 'new'
	end
	
end
