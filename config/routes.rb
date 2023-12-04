Rails.application.routes.draw do
  resources :links
  devise_for :users
  root "home#index"

  get "/l/:slug", to: "access#access", as: "access"
end
