Rails.application.routes.draw do
  scope "/:locale", shallow: true do
    devise_for :users, path: :account
    resources :comments, only: %i(show)
    resources :users, only: %i(index show)
    resources :notes do
      member do
        scope "/", controller: :notes do
          %w(quiz quiz-results review).each { |route| get route }
          %w(quiz-results).each { |route| post route }
        end
      end
      resources :comments, only: %i(create)
      collection { get :autocomplete }
    end
    scope "legal", controller: :legal do
      %w(privacy terms).each { |route| get route }
    end
    scope "/", controller: :home do
      get "contact" => redirect("/:locale/help")
      match "help", via: %i(get post)
    end
    root "home#index"
  end
  get "/" => redirect("/en")
end
