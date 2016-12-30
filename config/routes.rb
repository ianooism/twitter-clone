Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :users, only: [:index, :show]
  resources :users, only: {} do
    resources :relationships, only: [:create]
  end
  root to: 'pages#home'
end
