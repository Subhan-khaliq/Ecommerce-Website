# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  resources :orders
  resources :products do
    resources :comments
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'carts/:id' => 'carts#show', as: 'cart'
  get 'line_items/:id' => 'line_items#show', as: 'line_item'

  delete 'carts/:id' => 'carts#destroy'
  delete 'line_items/:id' => 'line_items#destroy'

  post 'line_items/:id/add' => 'line_items#add_quantity', as: 'line_item_add'
  post 'line_items' => 'line_items#create'
  post 'line_items/:id/reduce' => 'line_items#reduce_quantity', as: 'line_item_reduce'
end
