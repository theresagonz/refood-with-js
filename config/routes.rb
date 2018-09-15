Rails.application.routes.draw do
  get 'welcome/home'
  resources :offers
  resources :users
  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
