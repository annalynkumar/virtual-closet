Rails.application.routes.draw do
  devise_for :users

  resources :items
  resources :outfits   # you’ll want this soon too

  root to: "home#index"
end
