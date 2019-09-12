# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  
  devise_for :users, controllers:{omniauth_callbacks: "users/omniauth_callbacks"}
  
  post "/", to: "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/notfound", to: "static_pages#notfound"
  get "/tour", to:"tour_bookings#tour"
  get "/booking", to: "tour_bookings#new_booking"
  post "/booking", to: "tour_bookings#create_booking"
  get "/userbooking", to: "users#booking"
  get "/paymenthistory", to: "users#payment_history"
  get "/admin", to: "static_pages#admin_home"
  post "/recharge", to: "users#recharge"

  
  resources :users, only: [:show, :index]
  resources :posts
  resources :comments, only: [:create, :destroy]
  resources :tour_bookings
  resources :payments
  resources :account_activations, only: :edit
  resources :password_resets, except: [:index, :show, :destroy]

  namespace :admin do
    resources :categories, :slides, :tours, :bookings, :coupons
    resources :tours do
      resources :tourdetails
    end
  end
end
