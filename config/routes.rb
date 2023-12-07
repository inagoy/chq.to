Rails.application.routes.draw do
  resources :links
  devise_for :users
  root "home#index"
  get "/l/:slug", to: "links#access", as: "access"

  post '/l/protected/:slug', to: 'links#validate_password', as: 'validate_password'
end
