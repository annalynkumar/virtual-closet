class OutfitsController < ApplicationController
 def index
  @list_of_outfits = Outfit.order(created_at: :desc)
@items_grouped_by_category = Item.order(:created_at).group_by(&:category)

  @outfits = Outfit.all
  render({ :template => "outfit_templates/index" })
end

def new
  @outfit = Outfit.new
  @items = Item.where(user_id: current_user.id) # or however you're loading items
  render template: "outfit_templates/new"
end


 def show
  the_id = params.fetch("path_id")
  @the_outfit = Outfit.includes(:items).find(the_id)
  render template: "outfit_templates/show"
end

  def create
    the_outfit = Outfit.new
    the_outfit.name = params.fetch("query_name")
    the_outfit.occasion = params.fetch("query_occasion")
    the_outfit.user_id = params.fetch("query_user_id")

    if the_outfit.valid?
      the_outfit.save
      redirect_to("/outfits", { :notice => "Outfit created successfully." })
    else
      redirect_to("/outfits", { :alert => the_outfit.errors.full_messages.to_sentence })
    end
  end
end
