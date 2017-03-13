Rails.application.routes.draw do
  # ACCOUNT

  devise_for :users, path: 'account'

  {
    "signup" => "account/signup",
    "login" => "account/login",
    "account" => "account/edit",
  }.each { |current, towards| get current, to: redirect(towards) }

  resources :notes

  root "home#index"
end
