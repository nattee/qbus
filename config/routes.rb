Rails.application.routes.draw do
  resources :cars
  resources :routes
  resources :licensees
  resources :criteria
  resources :datafiles
  resources :attachments
  resources :criteria_groups
  resources :violations
  resources :logs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get 'static_pages/test1'

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

      get 'add_evidences'
      post 'add_attachment'
    end
    collection do
      get 'apply'
      post 'apply', to: 'applications#post_apply'
      get 'dashboard'
    end
  end

  resources :evaluations

  #process
  get  'process/dashboard'

  get  'process/registers',       to: 'process#registered_index'
  get  'process/register/:id',    to: 'process#registered', as: 'process_register'
  post 'process/register/:id',    to: 'process#registered_post', as: 'confirm_process_register'

  get  'process/appointments',    to: 'process#appointment_index'
  get  'process/appointment_form'
  post 'process/appointment',     to: 'process#appointment_post', as: 'appoint_process_appointment'
  get  'process/appointed/:id',   to: 'process#appointed', as: 'process_appointed'

  get  'process/verifications',   to: 'process#verification_index'
  get  'process/verification/:id',to: 'process#verification', as: 'process_verify'
  post 'process/verification/:id',to: 'process#verification_post'

  get  'process/evaluations',     to: 'process#evaluation_index'
  get  'process/evaluation/:id',  to: 'process#evaluation', as: 'process_evaluation'
  post 'process/evaluation/:id',  to: 'process#evaluation_post'

  get  'process/awards',          to: 'process#award_index'
  get  'process/award/:id',       to: 'process#award', as: 'process_award'
  post 'process/award/:id',       to: 'process#award_post'


end
