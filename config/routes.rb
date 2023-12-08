Rails.application.routes.draw do
  resources :links
  resources :regular_links, controller: 'links'
  resources :ephemeral_links, controller: 'links'
  resources :temporary_links, controller: 'links'
  resources :exclusive_links, controller: 'links'

  devise_for :users
  devise_scope :user do
    get "profile" => "devise/sessions#show"
  end

  root "home#index"

  get "/l/:slug", to: "links#access", as: "access"
  post '/l/protected/:slug', to: 'links#validate_password', as: 'validate_password'
end
