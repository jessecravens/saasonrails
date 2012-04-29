MicrobizRails32MongoDevise::Application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, path: 'accounts'

=begin
  constraints(Subdomain) do
    match '/' => '/users'
  end
=end

  root to: "home#index"

  resources :tokens, only: [:create, :destroy]

  resources :profiles do
    put :upload_avatar, on: :member
  end
end
