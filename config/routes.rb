Rails.application.routes.draw do
  devise_for :users, path: :account
  resources :notes
  root "home#index"
end
