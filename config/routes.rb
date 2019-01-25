Rails.application.routes.draw do
  root to: 'visitors#about'
  devise_for :users
  resources :users
  resources :poems
  get '/favourites' => 'poems#favourites', as: :favourites
  get '/subscribed' => 'poems#subscribed', as: :subscribed
  get '/written' => 'poems#written', as: :written
  get '/line/:id/write_more' => 'poems#write_another_version', as: :write_another_version
  post '/poems/:poem_id/create_another_version' => 'poems#create_another_version', as: :create_another_version
  get '/poems/:id/subscribe' => 'poems#toggle_subscribe', as: :subscribe_poem
  get '/version/:id/like' => 'poems#toggle_like', as: :like_version
  get '/top/poems' => 'poems#best_poems', as: :best_poems
  resources :tags

  #api
  namespace :api do
      resources :sessions, only: [:create]
      resources :poems, only: [:index, :create, :show, :update, :destroy]
      resources :tags, only: [:index, :create, :show, :update, :destroy]
      resources :users, only: [:index, :show]
  end
end
