MicrobizRails32MongoDevise::Application.routes.draw do
  root to: "home#index"

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, path: 'accounts'
end
