Rails.application.routes.draw do
  root to: "pages#home"

  mount StripeEvent::Engine, at: "/stripe-webhooks"
  devise_for :users # DON'T REMOVE, user routes are managed by devise!
  resources :users
  # , only: [:show, :index]

  # resources :tasks, except: [:show] do
    resources :tasks do
    # Everything below is related to a specific task 👇
    resources :helps, only: [:create, :update, :destroy]
    # resources :reviews

    patch "/assign/:helper_id", to: "tasks#assign", as: :assign
    patch "/complete", to: "tasks#complete", as: :complete
  end

  resources :payments, only: [:show]

  get "/oauth", to: "payments#oauth", as: :oauth

  get "/dashboard", to: "tasks#dashboard", as: :dashboard
end
