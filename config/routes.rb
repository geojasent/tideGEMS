Rails.application.routes.draw do
  get 'tides/weekly_view'
  root 'tides#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
