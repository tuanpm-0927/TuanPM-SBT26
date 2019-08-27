# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"

  get "/search", to: "static_pages#search"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "session#new"
  post "/login", to: "session#create"
  get "/logout", to: "session#destroy"
  get "/notfound", to: "static_pages#notfound"

  resources :users, except: %i[new]

  namespace :admin do
    resources :categories, :tours
  end
end
