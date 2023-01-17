Rails.application.routes.draw do

  root to: 'posts#index'

  # Posts CRUD operations
  resources :posts

  # Search using Elastic
  namespace :elastic do
    resources :posts, only: :index
  end

  # Search using PG fulltext
  namespace :fulltext do
    resources :posts, only: :index
  end
end
