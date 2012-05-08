class ProfilesController < ApplicationController
  def upload_avatar
    @profile = Profile.find(params[:id])
    @user = @profile.user

    @profile.attributes = params[:profile]

    if @profile.save
      flash[:notice] = "Profile successfully updated"
      redirect_to @user
    else
      flash[:notice] = "Error updating profile"
      redirect_to @user
    end
  end
end
