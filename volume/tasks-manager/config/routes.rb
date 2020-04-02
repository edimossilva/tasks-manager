Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login'

  resources :users, only: %i[] do
    resources :task_lists
  end

  mount ActionCable.server => '/cable'
end
