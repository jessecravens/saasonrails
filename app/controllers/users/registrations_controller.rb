class Users::RegistrationsController < Devise::RegistrationsController
  def new
    if session['devise.facebook_data'].present?
      params[:user] = { email: session['devise.facebook_data']['info']['email'] }
      params[:profile] = { first_name: session['devise.facebook_data']['info']['first_name'], last_name: session['devise.facebook_data']['info']['last_name'] }
    elsif session['devise.google_data'].present?
      params[:user] = { email: session['devise.google_data']['info']['email'] }
      params[:profile] = { first_name: session['devise.google_data']['info']['first_name'], last_name: session['devise.google_data']['info']['last_name'] }
    end

    params[:user] ||= {}
    params[:profile] ||= {}

    @company = Company.new
    @company.users.build(params[:user]).build_profile(params[:profile])
    respond_with @company
  end

  def create
    @company = Company.new
    @company.attributes = params[:company]
    @company.users.first.add_role :owner
    resource = @company.users.first

    if session['devise.facebook_data'].present?
      params[:authentication] = { provider: session['devise.facebook_data']['provider'], uid: session['devise.facebook_data']['uid'], access_token: session['devise.facebook_data']['credentials']['token'] }
      resource.authentications.build(params[:authentication])
    elsif session['devise.google_data'].present?
      params[:authentication] = { provider: session['devise.google_data']['provider'], uid: session['devise.google_data']['uid'] }
      resource.authentications.build(params[:authentication])
    end

    if @company.save
      @company.create_subscription(Plan.free_plan, nil)
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      flash[:error] = @company.errors.full_messages
      respond_with @company
    end
  end
end
