Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login'

  resources :users, only: %i[] do
    resources :task_lists, only: %i[destroy show update]
  end

  resources :tasks, only: %i[create destroy update]
  resources :task_lists, only: %i[create index]
  resources :task_in_lists, only: %i[create destroy]

  mount ActionCable.server => '/cable'
end
