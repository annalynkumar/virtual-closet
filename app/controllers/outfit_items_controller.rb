class OutfitItemsController < ApplicationController
  def index
    matching_outfit_items = OutfitItem.all
    @list_of_outfit_items = matching_outfit_items.order({ created_at: :desc })
    render template: "outfit_item_templates/index"
  end

  def new
    @items = current_user.items
    render template: "outfit_item_templates/new"
  end

  def show
    the_id = params.fetch("path_id")
    matching_outfit_items = OutfitItem.where(id: the_id)
    @the_outfit_item = matching_outfit_items.at(0)
    render template: "outfit_item_templates/show"
  end

  def create
    new_outfit = Outfit.new
    new_outfit.name = params[:outfit_name]
    new_outfit.user_id = current_user.id

    if new_outfit.save
      item_ids_array = params[:item_ids] || []
      item_ids_array.each do |item_id|
        OutfitItem.create(outfit_id: new_outfit.id, item_id: item_id)
      end
      redirect_to "/outfits/#{new_outfit.id}", notice: "Outfit created!"
    else
      redirect_to "/outfit_items/new", alert: "Something went wrong."
    end
  end


end
