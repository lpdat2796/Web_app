Rails.application.routes.draw do

  root "home#index"
  
  resources :search, only: [:index, :destroy]

  post 'get'            =>    'search#get'
  get 'show'            =>    'search#show'

  devise_for :users
  as :user do
    get "login"             =>  "devise/sessions#new"
    post "login"            =>  "devise/sessions#create"
    delete "logout"         =>  "devise/sessions#destroy"
    get "register"          =>  "devise/registrations#new"
    post "register"         =>  "devise/registrations#create"
    get "user/edit"         =>  "devise/registrations#edit"
    get "password/reset"    =>  "devise/passwords#new"
    get "password/reset"    =>  "devise/passwords#create"
    get "password/update"   =>  "devise/passwords#edit"
    get "register/confirm"  =>  "devise/confirmations#show"
    post "register/confirm" =>  "devise/confirmations#create"
  end
  
  
  namespace :admin do
    root :to => "users#index"
    resources :users, only: [:index, :update, :create, :destroy]
    get 'new'               =>  "users#new"
    get 'edit'              =>  "users#edit"
  end

     #define route edit user trong cái scope :user nest trong namspace admin
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
