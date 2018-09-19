Rails.application.routes.draw do
  root 'welcome#home'
  
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  get '/index' => 'welcome#index'

  get '/auth/google_oauth2/callback' => 'sessions#create_with_google'

  
  resources :offers do
    resources :requests
  end

  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
