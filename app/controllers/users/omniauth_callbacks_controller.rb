class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'], current_user)

    if @user.present?
      # Save facebook authentication if not already present
      facebook_auth = @user.authetications.facebook
      unless facebook_auth.present?
        params[:authentication] = { provider: request.env['omniauth.auth']['provider'], uid: request.env['omniauth.auth']['uid'], access_token: request.env['omniauth.auth']['credentials']['token'] }
        @user.authetications.create(params[:authentication])
      end

      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Facebook'
      sign_in_and_redirect @user, event: :authentication
    else
      request.env['omniauth.auth'].delete 'extra'
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
    end
  end
end