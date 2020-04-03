Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login'

  resources :users, only: %i[] do
    resources :task_lists, only: %i[destroy show update]
  end

  resources :tasks, only: %i[create destroy update]
  resources :task_lists, only: %i[create index]

  mount ActionCable.server => '/cable'
end
