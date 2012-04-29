class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    # root_url(subdomain: resource.company.subdomain)
  end
end
