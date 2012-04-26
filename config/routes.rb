MicrobizRails32MongoDevise::Application.routes.draw do
  root to: "home#index"

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, path: 'accounts'

  resources :profiles do
    put :upload_avatar, on: :member
  end
end
