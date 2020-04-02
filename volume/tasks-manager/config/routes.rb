Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login'

  resources :users, only: %i[] do
    resources :task_lists, only: %i[create destroy update]
  end

  mount ActionCable.server => '/cable'
end
