# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home", param: :category_id

  post "/search", to: "static_pages#search"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "session#new"
  post "/login", to: "session#create"
  get "/logout", to: "session#destroy"
  get "/notfound", to: "static_pages#notfound"
  get "/book/:tour_id" => "bookings#new", :as=>:book

  resources :users, except: %i[new]
  resources :posts
  resources :comments, only: [:create, :destroy]
  resources :bookings, except: %i[new]

  namespace :admin do
    resources :categories, :tours, :slides
  end
end
