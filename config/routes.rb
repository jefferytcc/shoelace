Rails.application.routes.draw do


  resources :shoes
	#homepage
  root 'shoes#index'

  #user sign in
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'


  #user sign-up and etc
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
