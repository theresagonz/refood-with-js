Rails.application.routes.draw do
  root 'welcome#home'
  
  resources :users, only: [:update, :show, :destroy]
  get '/add-info' => 'users#add_info'
  get '/edit-profile' => 'users#edit'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/user' => 'users#user'
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  get '/auth/google_oauth2/callback' => 'sessions#create_with_google'
  
  get '/index' => 'welcome#index'  

  # get '/offers/expired' => 'offers#expired'
  
  get '/offers/closed' => 'offers#closed'
  
  get '/current-offers' => 'offers#current_offers'

  resources :offers do
    resources :requests
    get '/completed' => 'requests#offer_completed'
  end

  get '/requests/completed' => 'requests#completed'
  patch '/request/:id' => 'requests#complete'
  
  post '/comments' => 'comments#create'

  get '/requests/recently-completed' => 'requests#recently_completed'

  get '/offers-by-location' => 'offers#by_location'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
