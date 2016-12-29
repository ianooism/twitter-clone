Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :users, only: [:index, :show]
  root to: 'posts#index'
end
