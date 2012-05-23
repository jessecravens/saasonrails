class UsersController < ApplicationController
  before_filter :init_user_instance, only: [:create]
  load_and_authorize_resource except: [:create]

  # GET /users/new
  def new 
    @user = User.new
    @user.build_profile
    @user.company = current_user.company
    @roles = Role.roles_by_ability current_user
  end 

  # POST /users
  def create
    #@user = User.new params[:user]
    #@user.company = current_user.company
    if @user.save
      flash[:notice] = "#{ @user.email } was successfully created. A confirmation email has been sent."
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages
      @user.build_profile if @user.profile.nil?
      @roles = Role.all
      render :action => 'new'
    end 
  end

  # GET /users
  def index
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  # GET /users/1
  def show
  end

  # GET /users/1/edit
  def edit
    @roles = Role.roles_by_ability current_user
  end

  # PUT /users/1
  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if(params[:user][:password].blank? && params[:user][:password_confirmation].blank?)
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated User."
      redirect_to users_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "#{ @user.email } was deleted successfully."
      redirect_to users_path
    end
  end

  def fb_post
    user = User.find(params[:id])
    fb_auth = user.authentications.facebook.first

    me = FbGraph::User.me(fb_auth.access_token)
    me.feed!(message: params[:message])

    # graph = Koala::Facebook::API.new(fb_auth.access_token)
    # graph.put_wall_post(params[:message])

    redirect_to user, notice: 'Message posted to Facebook'
  end

  private 

  def init_user_instance
    @user = User.new params[:user]
    @user.company = current_user.company
  end
end
