class UsersController < ApplicationController
  def new 
    @user = User.new
    @user.build_profile
    @roles = Role.all
  end 

  def create
    @user = User.new params[:user]
    @user.company = current_user.company
    if @user.save
      flash[:notice] = "#{ @user.email } was successfully created."
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages
      @user.build_profile if @user.profile.nil?
      @roles = Role.all
      render :action => 'new'
    end 
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
