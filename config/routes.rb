Rails.application.routes.draw do
  resources :tide_stations
  get 'tides/weekly_view'
  root 'tides#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
