class RefereesController < ApplicationController
  
  before_action :user_logged_in, only: [:new,:create,:destroy,:edit, :update]
  before_action :ensure_contest_creator, only: [:new, :create, :edit, :update]
  
  def new
    @referee = current_user.referees.build
  end
  
  def create
    @referee = current_user.referees.build(acceptable_params)
    if @referee.save
      flash[:success] = 'Referee created.'
      redirect_to @referee
    else
      flash[:danger]="Error while trying to create the referee!"
      render 'new'
    end
  end
  
  def edit 
    @referee = Referee.find(params[:id])
  end  
  
  def show
    @referee = Referee.find(params[:id])
  end
  
  def index
    @referees = Referee.all
  end
  
  def destroy
    @referee = Referee.find(params[:id])
    if current_user?(@referee.user)
      @referee.destroy
      flash[:success] = "Referee destroyed."
      redirect_to referees_path
    else
      flash[:danger] = "Can't delete referee."
      redirect_to root_path
    end 
  end
  
  def update
    @referee = Referee.find(params[:id])
    if @referee.update_attributes(acceptable_params)
      flash[:success] = "Referee has been updated!"
      redirect_to @referee
    else
      flash[:danger]="Error while trying to update the referee!"
      render 'edit'
    end
  end
      
  private
  
  def acceptable_params
    params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
  end
  
  def user_logged_in
    redirect_to login_path, flash: { :warning => "Unable, not logged in" } unless logged_in?
  end
  
  def ensure_contest_creator 
      redirect_to root_path, flash: { :danger => "You are not a contest creator" } unless current_user.contest_creator?
  end
  
  def ensure_correct_user
    @referee = Referee.find(params[:id])
    redirect_to root_path, flash: { :danger => "Must be Logged in!" } unless current_user?(@referee.user_id)
  end
  
end
