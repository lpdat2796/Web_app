# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  resources :search, only: [:index]

  resources :books, only: %i[index create destroy]

  devise_for :users
  as :user do
    get 'login' => 'devise/sessions#new'
    post 'login' => 'devise/sessions#create'
    delete 'logout' => 'devise/sessions#destroy'
    get 'register' => 'devise/registrations#new'
    post 'register' => 'devise/registrations#create'
    get 'user/edit'         =>  'devise/registrations#edit'
    get 'password/reset'    =>  'devise/passwords#new'
    get 'password/reset'    =>  'devise/passwords#create'
    get 'password/update'   =>  'devise/passwords#edit'
  end

  namespace :admin do
    root to: 'users#index'
    resources :users, only: %i[index update create destroy]
    get 'new'               =>  'users#new'
    get 'edit'              =>  'users#edit'
  end

  # define route edit user trong cái scope :user nest trong namspace admin
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
