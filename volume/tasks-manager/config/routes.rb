Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login'

  resources :users, only: %i[] do
    resources :task_lists
  end

  resources :tasks, only: %i[create update]

  mount ActionCable.server => '/cable'
end
