Rails.application.routes.draw do
  resources :routes
  resources :licensees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  resources :users

  resources :account_activations, only: [:edit]

  #session
  get 'register', to: 'sessions#register'
  post 'register', to: 'sessions#register_post'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'profile', to: 'sessions#profile'

  resources :applications do
    member do
      get 'apply_step1'
      get 'apply_step2'
      get 'apply_step3'
      post 'apply_step1', to: 'applications#post_step1'
      post 'apply_step2', to: 'applications#post_step2'
      post 'apply_step3', to: 'applications#post_step3'

      post 'add_car', to: 'applications#add_car'
    end
    collection do
      get 'apply'
      post 'apply', to: 'applications#post_apply'
      get 'dashboard'
    end
  end

  resources :evaluations

  #process
  get  'process/appointments',     to: 'process#appointment_index'
  get  'process/appointment_form'
  post 'process/appointment',     to: 'process#appointment_post', as: 'appoint_process_appointment'
  get  'process/appointed/:id',   to: 'process#appointed', as: 'process_appointed'
  get  'process/evaluations',     to: 'process#evaluation_index'
  get  'process/evaluation/:id',  to: 'process#evaluation', as: 'process_evaluation'
  post 'process/evaluation/:id',  to: 'process#evaluation_post'
  get  'process/award',           to: 'process#award_index'
  get  'process/award/:id',       to: 'process#award'
  post 'process/award/:id',       to: 'process#award_post'


end
