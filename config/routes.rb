Rails.application.routes.draw do
  devise_for :users

  resources :search, only: [:index]

  get 'search'      =>    'search#index'
  post 'get'        =>    'search#get'
  get 'show'        =>    'search#show'
  
  # get "signin"      =>  "devise/sessions#new"
  # post "signin"     =>  "devise/sessions#create"
  # delete "signout"  =>  "devise/sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
