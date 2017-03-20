Rails.application.routes.draw do
  get "aggregates/search", to: "aggregates#search"
  get "aggregates/download", to: "aggregates#download"
  get "aggregates/explore", to: "aggregates#explore"
  resources :subcategories
  resources :aggregates
  resources :categories
  root 'aggregates#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
