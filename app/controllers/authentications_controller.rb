class AuthenticationsController < ApplicationController
  def destroy
    @authentication = Authentication.find(params[:id])
    @user = @authentication.user

    if @authentication.destroy
      flash[:notice] = "#{@authentication.provider.titleize} authentication successfully removed"
    else
      flash[:notice] = "Unable to remove #{@authentication.provider.titleize} authentication"
    end

    redirect_to @user
  end
end
