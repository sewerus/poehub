Rails.application.routes.draw do
  root to: 'visitors#about'
  devise_for :users
  resources :users
  resources :poems
  get '/favourites' => 'poems#favourites', as: :favourites
  get '/subscribed' => 'poems#subscribed', as: :subscribed
  get '/written' => 'poems#written', as: :written
  resources :tags

  #api
  namespace :api do
      resources :sessions, only: [:create]
      resources :poems, only: [:index, :create, :show, :update, :destroy]
      resources :tags, only: [:index, :create, :show, :update, :destroy]
      resources :users, only: [:index, :show]
  end
end
