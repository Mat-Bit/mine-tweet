Rails.application.routes.draw do

  resources :tweets

  post '/tweets_search' => 'tweets#search'

  root 'tweets#index'
  
end
