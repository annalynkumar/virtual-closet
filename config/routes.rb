Rails.application.routes.draw do
  # Routes for the Outfit item resource:

  # CREATE
  get("/outfit_items/new", { :controller => "outfit_items", :action => "new" })
  post("/insert_outfit_item", { :controller => "outfit_items", :action => "create" })

  get "/items/new", to: "items#new"
post "/insert_item", to: "items#create"


  # READ
  get("/outfit_items", { :controller => "outfit_items", :action => "index" })

  get("/outfit_items/:path_id", { :controller => "outfit_items", :action => "show" })

  # UPDATE

  post("/modify_outfit_item/:path_id", { :controller => "outfit_items", :action => "update" })

  # DELETE
  get("/delete_outfit_item/:path_id", { :controller => "outfit_items", :action => "destroy" })

  #------------------------------

  # Routes for the Outfit resource:

  # CREATE
  post("/insert_outfit", { :controller => "outfits", :action => "create" })

  # READ
  get("/outfits", { :controller => "outfits", :action => "index" })

  get("/outfits/:path_id", { :controller => "outfits", :action => "show" })

  # UPDATE

  post("/modify_outfit/:path_id", { :controller => "outfits", :action => "update" })

  # DELETE
  get("/delete_outfit/:path_id", { :controller => "outfits", :action => "destroy" })

  #------------------------------

  # Routes for the Item resource:

  # CREATE
  post("/insert_item", { :controller => "items", :action => "create" })

  # READ
  get("/items", { :controller => "items", :action => "index" })
get("/items/:path_id", { :controller => "items", :action => "show" })
get "/items/:id" => "items#show", as: :item

resources :items
# config/routes.rb
resources :outfits, only: [:index, :create]
resources :items, only: [:index, :show]



get "/closet", to: "closet#index"


  # UPDATE

  post("/modify_item/:path_id", { :controller => "items", :action => "update" })

  # DELETE
  get("/delete_item/:path_id", { :controller => "items", :action => "destroy" })

#------------------------------

devise_for :users, sign_out_via: :delete

  resources :items
  resources :outfits

  root to: "home#index"
end
