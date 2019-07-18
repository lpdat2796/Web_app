Rails.application.routes.draw do
  devise_for :users, path_names: 
                                { sign_in: 'login',
                                  sign_out: 'logout',
                                  password: 'secret',
                                  confirmation: 'verification',
                                  unlock: 'unblock',
                                  registration: 'register',
                                  sign_up: 'signup' 
                                }

  root "home#index"

  resources :search
  
  get 'search/index'      =>    'search#index'
  
  # get "signin"      =>  "devise/sessions#new"
  # post "signin"     =>  "devise/sessions#create"
  # delete "signout"  =>  "devise/sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
