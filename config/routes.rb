Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get 'sessions/destroy'
  get 'welcome/home'
  resources :offers
  resources :users
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
