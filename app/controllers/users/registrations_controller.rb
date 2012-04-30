class Users::RegistrationsController < Devise::RegistrationsController
  def new 
    #resource = build_resource {}
    @company = Company.new
    @company.users.build.build_profile
    respond_with @company
  end

  def create
    @company = Company.new
    @company.attributes = params[:company]
    owner = @company.users.first
    @company.owner = owner
    owner.add_role :owner
    resource = owner

    if @company.save
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
