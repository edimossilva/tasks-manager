Rails.application.routes.draw do
  apipie
  post '/auth/login', to: 'authentication#login'

  resources :tasks, only: %i[create destroy update]
  resources :task_lists, only: %i[create destroy index show update]
  resources :task_in_lists, only: %i[create destroy]

  mount ActionCable.server => '/cable'
end
