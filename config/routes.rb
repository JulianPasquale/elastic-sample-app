Rails.application.routes.draw do
  namespace :elastic do
    resources :posts
  end
end
