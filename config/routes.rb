# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/:locale', shallow: true do
    #
    # User
    #

    resources :notes do
      member do
        scope '/', controller: :notes do
          %w[quiz quiz-results review].each { |route| get route }
          %w[quiz-results].each { |route| post route }
        end
      end
      resources :comments, only: %i[show create update destroy]
      resource :vote, only: %i[create destroy]
      collection { get :autocomplete }
    end
    resources :users, only: %i[index show]

    #
    # Guest
    #

    devise_for :users, path: :account
    scope 'legal', controller: :legal do
      %w[privacy terms].each { |route| get route }
    end

    # NOTE: Temporarily removed contact page.
    # scope "/", controller: :home do
    #   get "contact" => redirect("/:locale/help")
    #   match "help", via: %i(get post)
    # end

    scope '/demo', as: :demo, controller: :demo do
      get '/' => 'demo#index'
      %w[reload quiz].each { |route| get route => "demo##{route}" }
      %w[review quiz-results].each { |route| match route, via: %i[get post] }
    end
    root 'home#index'
  end
  get '/' => redirect('/en')
end
