Rails.application.routes.draw do


  

  #create show and etc
  resources :shoes


	#homepage
  root 'static_pages#home'

  #user sign in
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  #user sign-up and etc
  resources :users 

  #user add to cart
  resource :cart, only: [:show] do
    put 'add/:shoe_id', to: 'carts#add', as: :add_to
    put 'remove/:shoe_id', to: 'carts#remove', as: :remove_from
  end
  
## Braintree payments
  # Payment Info
resources :transactions, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
