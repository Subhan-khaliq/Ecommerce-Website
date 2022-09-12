# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :users
  # devise_for :users
  # # devise_for :users, controllers: { registrations: "registrations"}
  # devise_for :users, path: 'auth',
  #                    path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  # devise_scope :user do
  #   get 'sign_in', to: 'users/registrations#new'
  # end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'}
  # devise_for  :users,
  #             :path => 'users',
  #             :path_names => {  :sign_in =>       'login',
  #                               :sign_out =>      'logout',
  #                               :sign_up =>       '',
  #                               :registration =>  'registrations',
  #                               :edit =>          'edit',
  #                               :cancel =>        'cancel',
  #                               :confirmation =>  'verification'  }

  # as :user do

  #   get '/' => 'users/registrations#new'

  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
