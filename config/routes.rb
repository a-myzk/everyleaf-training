Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  root to: 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
