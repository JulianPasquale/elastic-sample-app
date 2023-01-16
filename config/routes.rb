Rails.application.routes.draw do
  namespace :elastic do
    resources :posts
  end

  namespace :fulltext do
    resources :posts
  end
end
