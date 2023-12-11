Rails.application.routes.draw do
  root "home#index"

  resources :links
  resources :regular_links, controller: 'links'
  resources :ephemeral_links, controller: 'links'
  resources :temporary_links, controller: 'links'
  resources :exclusive_links, controller: 'links'
  get "/links/:id/visits", to: "links#visits", as: "visits"
  get "/l/:slug", to: "links#access", as: "access"
  post '/l/protected/:slug', to: 'links#validate_password', as: 'validate_password'

  devise_for :users
  devise_scope :user do
    get "profile" => "devise/sessions#show"
  end

end
