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
  scope "legal", controller: :legal do
    %w(privacy terms).each { |route| get route }
  end
  scope "/", controller: :home do
    %w(contact).each { |route| get route }
  end
  root "home#index"
end
