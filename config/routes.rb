Rails.application.routes.draw do
  resources :subcategories
  resources :aggregates
  resources :categories
  root 'aggregates#index'
  get "aggregates/search", to: "aggregates#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
