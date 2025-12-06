class ItemsController < ApplicationController

  def new
  @the_item = Item.new
  render template: "item_templates/new"
end

  def index
    matching_items = Item.all

    @list_of_items = matching_items.order({ :created_at => :desc })

    render({ :template => "item_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_items = Item.where({ :id => the_id })

    @the_item = matching_items.at(0)

    render({ :template => "item_templates/show" })
  end

  def create
  the_item = Item.new
  the_item.name = params.fetch("query_name")
  the_item.category = params.fetch("query_category")
  the_item.color = params.fetch("query_color")
  the_item.image_url = params.fetch("query_image_url")
  the_item.user_id = current_user.id   # ← FIXED HERE

  if the_item.valid?
    the_item.save
    redirect_to("/items", { :notice => "Item created successfully." })
  else
    redirect_to("/items", { :alert => the_item.errors.full_messages.to_sentence })
  end
end

  def update
    the_id = params.fetch("path_id")
    the_item = Item.where({ :id => the_id }).at(0)

    the_item.name = params.fetch("query_name")
    the_item.category = params.fetch("query_category")
    the_item.color = params.fetch("query_color")
    the_item.image_url = params.fetch("query_image_url")
    the_item.user_id = params.fetch("query_user_id")

    if the_item.valid?
      the_item.save
      redirect_to("/items/#{the_item.id}", { :notice => "Item updated successfully." } )
    else
      redirect_to("/items/#{the_item.id}", { :alert => the_item.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_item = Item.where({ :id => the_id }).at(0)

    the_item.destroy

    redirect_to("/items", { :notice => "Item deleted successfully." } )
  end
end
