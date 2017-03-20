Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  {
   "account" => "/",
 }.each { |current, towards| get current, to: redirect(towards) }

  resources :notes
  root "home#index"
end
