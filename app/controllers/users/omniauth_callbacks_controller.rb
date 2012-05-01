class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'], current_user)

    if user_signed_in?
      @user = current_user
      facebook_auth = @user.authentications.facebook
      unless facebook_auth.present?
        params[:authentication] = { provider: request.env['omniauth.auth']['provider'], uid: request.env['omniauth.auth']['uid'], access_token: request.env['omniauth.auth']['credentials']['token'] }
        @user.authentications.create(params[:authentication])
      end

      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Facebook'
      redirect_to @user
    elsif @user.present?
      # Save facebook authentication if not already present
      facebook_auth = @user.authentications.facebook
      unless facebook_auth.present?
        params[:authentication] = { provider: request.env['omniauth.auth']['provider'], uid: request.env['omniauth.auth']['uid'], access_token: request.env['omniauth.auth']['credentials']['token'] }
        @user.authentications.create(params[:authentication])
      end

      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Facebook'
      sign_in_and_redirect @user, event: :authentication
    else
      request.env['omniauth.auth'].delete 'extra'
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
    end
  end

  def google
    @user = User.find_for_open_id(request.env['omniauth.auth'], current_user)

    if user_signed_in?
      @user = current_user
      google_auth = @user.authentications.google
      unless google_auth.present?
        params[:authentication] = { provider: request.env['omniauth.auth']['provider'], uid: request.env['omniauth.auth']['uid'] }
        @user.authentications.create(params[:authentication])
      end

      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Google'
      redirect_to @user
    elsif @user.present?
      # Save google authentication if not already present
      google_auth = @user.authentications.google
      unless google_auth.present?
        params[:authentication] = { provider: request.env['omniauth.auth']['provider'], uid: request.env['omniauth.auth']['uid'] }
        @user.authentications.create(params[:authentication])
      end

      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Google'
      sign_in_and_redirect @user, :event => :authentication
    else
      request.env['omniauth.auth'].delete 'extra'
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
    end
  end
end