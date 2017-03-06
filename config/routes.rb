Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_frozen', on: :member
  end
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  get 'beerlist', to:'beers#list'
  get 'brewerieslist', to:'breweries#list'

  resources :places, only:[:index, :show]
  post 'places', to:'places#search'

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'

  delete 'signout', to: 'sessions#destroy'

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  root 'breweries#index'
end