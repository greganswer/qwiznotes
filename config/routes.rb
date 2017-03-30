Rails.application.routes.draw do
  devise_for :users, path: :account
  resources :notes do
    member do
        scope "/", controller: :notes do
          %w(quiz quiz-results review).each { |route| get route }
          %w(quiz-results).each { |route| post route }
        end
      end
  end
  root "home#index"
end
