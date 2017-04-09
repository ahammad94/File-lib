Rails.application.routes.draw do
  get "aggregates/newOnline", to: "aggregates#newOnline"
  post "aggregates/parse_online", to: "aggregates#parse_online"
  post "aggregates/create_folder", to: "aggregates#create_folder"
  get "aggregates/search", to: "aggregates#search"
  get "aggregates/remove_subcategory", to: "aggregates#remove_subcategory"
  get "aggregates/add_subcategory", to: "aggregates#add_subcategory"
  get "aggregates/remove_category", to: "aggregates#remove_category"
  get "aggregates/add_category", to: "aggregates#add_category"
  get "aggregates/search", to: "aggregates#search"
  get "aggregates/download", to: "aggregates#download"
  get "aggregates/explore", to: "aggregates#explore"
  resources :subcategories
  resources :aggregates
  resources :categories
  root 'aggregates#index' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
