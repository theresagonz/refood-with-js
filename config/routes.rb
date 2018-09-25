Rails.application.routes.draw do
  root 'welcome#home'
  
  resources :users, except: [:new, :create, :edit]
  get '/add-info' => 'users#add_info'
  get '/edit-profile' => 'users#edit'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  get '/auth/google_oauth2/callback' => 'sessions#create_with_google'
  
  get '/index' => 'welcome#index'  

  get '/offers/expired' => 'offers#expired'
  
  resources :offers do
    resources :requests
  end
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
