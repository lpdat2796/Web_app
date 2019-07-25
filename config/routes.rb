Rails.application.routes.draw do
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
    get "admin/login"       =>  "devise/sessions#new"
    post "admin/login"      =>  "devise/sessions#create"
  end
  
  root "home#index"

  resources :search, only: [:index]
  
  get 'search/index'        =>  'search#index'
  
  resources :admin, only: [:index, :edit, :new, :update]

  get "admin/edit"          =>  "admin#edit"
  get "admin/new"           =>  "admin#new"
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
