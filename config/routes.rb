Rails.application.routes.draw do
  resources :routes
  resources :licensees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  resources :users

  resources :applications do
    member do
      get 'apply_step1'
      get 'apply_step2'
      get 'apply_step3'
      post 'apply_step1', to: 'applications#post_step1'
      post 'apply_step2', to: 'applications#post_step2'
      post 'apply_step3', to: 'applications#post_step3'
    end
    collection do
      get 'apply'
      post 'apply', to: 'applications#post_apply'
      get 'dashboard'
    end
  end

end
