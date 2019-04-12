Rails.application.routes.draw do
  get 'report/award'
  resources :cars
  resources :routes
  resources :licensees
  resources :criteria
  resources :datafiles
  resources :attachments
  resources :criteria_groups
  resources :violations
  resources :logs
  resources :public_comments do
    collection do
      get 'application/:application_id', to: 'public_comments#application'
    end
  end
  resources :announcements do
    member do
      get 'publish'
      delete 'main_attachment', to: 'announcements#delete_main_attachment', as: 'delete_main_attachment'
      delete 'other_attachments/:attachment_id', to: 'announcements#delete_other_attachments', as: 'delete_other_attachments'
    end
  end
  get 'public_announcement', to: 'announcements#lists'
  get 'add_comment', to: 'public_comments#add_comment'
  post 'add_comment', to: 'public_comments#add_comment_post'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get 'static_pages/test1'

  resources :users
  get 'users/:id/edit/:profile', to: 'users#edit', as: 'profile_edit_user'


  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

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
      get 'fail_self_evaluation'
      post 'apply_step1', to: 'applications#post_step1'
      post 'apply_step2', to: 'applications#post_step2'
      post 'apply_step3', to: 'applications#post_step3'

      post 'add_car', to: 'applications#add_car'
      delete 'remove_car/:car_id', to: 'applications#remove_car', as: 'remove_car'

      get 'add_evidences'
      post 'add_attachment'
      get 'finish_add_evidences'
      get 'extend_from'
      get 'show_full'
    end
    collection do
      get 'apply'
      get 'extend'
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
  get  'process/appointment/visit/:id', to: 'process#appointment_visit', as: 'appointment_visit'
  post 'process/appointment/visit/:id', to: 'process#appointment_visit_post'
  post 'process/appointment',     to: 'process#appointment_post', as: 'appoint_process_appointment'
  get  'process/appointed/:id',   to: 'process#appointed', as: 'process_appointed'

  get  'process/verifications',   to: 'process#verification_index'
  get  'process/verification/:id',to: 'process#verification', as: 'process_verify'
  post 'process/verification/:id',to: 'process#verification_post'

  get  'process/evaluations',     to: 'process#evaluation_index'
  get  'process/evaluation/:id',  to: 'process#evaluation', as: 'process_evaluation'
  post 'process/evaluation/:id',  to: 'process#evaluation_post'
  post 'process/evaluation/:id/finish',  to: 'process#evaluation_finish', as: 'process_evaluation_finish'
  post 'process/evaluation/:id/reject',  to: 'process#evaluation_reject', as: 'process_evaluation_reject'

  get  'process/awards',          to: 'process#award_index'
  get  'process/award/:id',       to: 'process#award', as: 'process_award'
  post 'process/award/:id',       to: 'process#award_post'


end
