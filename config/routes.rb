Rails.application.routes.draw do

  resources :tweets

  resources :hashtags

  get '/list_tweets' => 'list_tweets#index'

  post '/tweets_search' => 'tweets#search'

  root 'hashtags#index'
  
end
