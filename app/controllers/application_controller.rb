class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :validate_company, unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    root_url subdomain: resource.company.subdomain
  end

  def after_sign_out_path_for(resource)
    root_url subdomain: false
  end

  def validate_company  
    if ['www', ''].include? request.subdomain
      redirect_to root_url(subdomain: current_user.company.subdomain) if user_signed_in? 
    else
      @current_company = Company.where(subdomain: request.subdomain).first rescue nil
      if @current_company.nil? || !can?(:belongs_to, @current_company)
        sign_out current_user
        redirect_to new_user_session_url(subdomain: false), notice: 'Please sign in'
      end
    end
  end
end
