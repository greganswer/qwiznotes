Rails.application.routes.draw do
  resources :notes
  root "home#index"
end
