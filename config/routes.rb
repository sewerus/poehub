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
      # resources :users, only: [:index, :create, :show, :update, :destroy] do
      #   namespace :links do
      #     resources :followers, only: [] do
      #       add_relationship_links.call
      #     end
      #     resources :following, only: [] do
      #       add_relationship_links.call
      #     end
      #   end
      # end
      resources :poems, only: [:index, :create, :show, :update, :destroy]
      resources :sessions, only: [:create]
  end
end
