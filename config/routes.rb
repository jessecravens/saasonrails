MicrobizRails32MongoDevise::Application.routes.draw do

  authenticated :user do
    root to: 'home#index'
  end
  as :user do
    match '/user/confirmation' => 'users/confirmations#update', via: :put, as: :update_user_confirmation
  end
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks', confirmations: 'users/confirmations' }
  
  constraints(Subdomain) do
    resources :authentications, only: [:destroy]
    resources :users, path: 'accounts'
    # resources :tokens, only: [:create, :destroy]
    resources :profiles do
      put :upload_avatar, on: :member
    end
  end

  root to: 'home#index'

end
