MicrobizRails32MongoDevise::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, path: 'accounts'

  constraints(Subdomain) do
    match '/' => 'home#index'
  end

  root to: "home#index"

  resources :tokens, only: [:create, :destroy]
  resources :authentications, only: [:destroy]
  resources :profiles do
    put :upload_avatar, on: :member
  end
end
