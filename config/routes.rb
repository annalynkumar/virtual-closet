Rails.application.routes.draw do
  devise_for :users

  resources :items
  resources :outfits 

  root to: "home#index"
end
