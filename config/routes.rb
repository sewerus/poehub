Rails.application.routes.draw do
  root to: 'visitors#about'
  devise_for :users
  resources :users
  resources :poems
  get '/favourites' => 'poems#favourites', as: :favourites
  get '/subscribed' => 'poems#subscribed', as: :subscribed
  get '/written' => 'poems#written', as: :written
  resources :tags
end
