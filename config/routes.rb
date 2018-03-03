Rails.application.routes.draw do
  resources :users, except: [:index]
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  post '/transfer' => 'transcation#transfer'
  get '/auth/failure' => 'sessions#failure'
end
