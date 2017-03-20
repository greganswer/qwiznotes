Rails.application.routes.draw do
  devise_for :users, path: :account, controllers: { registrations: 'registrations' }
  resources :notes
  root "home#index"
end
