Rails.application.routes.draw do
  get 'list_tweets/index'

  resources :tweets

  root 'list_tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
