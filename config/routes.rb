Rails.application.routes.draw do
  resources :routes
  resources :licensees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  resources :users
end
