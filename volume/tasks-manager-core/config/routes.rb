Rails.application.routes.draw do
  apipie
  post '/auth/login', to: 'authentication#login'

  resources :tasks, only: %i[create destroy update]
  resources :task_lists
  resources :task_in_lists, only: %i[create destroy update]
  resources :task_with_task_list, only: %i[create]
  resources :clean_test_data, only: %i[index]

  mount ActionCable.server => '/cable'
end
