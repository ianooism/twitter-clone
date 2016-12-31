Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :users, only: [:index, :show]
  scope 'relationships' do
    post '/:user_id', to: 'relationships#create', as: 'relationships'
    delete '/:user_id', to: 'relationships#destroy', as: 'relationship'
  end
  root to: 'pages#home'
end
