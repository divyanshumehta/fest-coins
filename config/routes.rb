Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/dm', as: 'rails_admin'
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  post '/transfer' => 'transcation#transfer'
  get '/auth/failure' => 'sessions#failure'
  get '/search/user' => 'users#search'
  post '/refferal' => 'users#refferal'
end
