MicrobizRails32MongoDevise::Application.routes.draw do

  as :user do
    match '/user/confirmation' => 'users/confirmations#update', via: :put, as: :update_user_confirmation
  end
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks', confirmations: 'users/confirmations' }

  constraints(Subdomain) do
    authenticated :user do
      root to: 'users#index'
    end
    resources :authentications, only: [:destroy]
    resources :users, path: 'accounts' do
      put :fb_post, on: :member
      member do 
        post :create_token
        delete :destroy_token
      end
    end
    resources :profiles do
      put :upload_avatar, on: :member
    end
    resources :subscriptions, only: [:index, :edit, :update]
  end

  root to: 'home#index'
end
