# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  resources :charges, only: %i[new create]
  resources :orders
  resources :products do
    resources :comments
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get 'carts/:id' => 'carts#show', as: 'cart'
  get 'line_items/:id' => 'line_items#show', as: 'line_item'
  get '/login', to: 'sessions#new'

  delete '/logout',  to: 'sessions#destroy'
  delete 'carts/:id' => 'carts#destroy'
  delete 'line_items/:id' => 'line_items#destroy'

  post  '/login', to: 'sessions#create'
  post 'line_items/:id/add' => 'line_items#add_quantity', as: 'line_item_add'
  post 'line_items/:id/reduce' => 'line_items#reduce_quantity', as: 'line_item_reduce'
  post 'line_items' => 'line_items#create'
  post 'orders/:id/' => 'orders#apply_coupons', as: 'apply_coupon'
end
