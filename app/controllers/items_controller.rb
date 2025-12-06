class ItemsController < ApplicationController
  def index
    # form at the top of the page needs a fresh Item object
    @item = Item.new

    matching_items = Item.all
    @list_of_items = matching_items.order(created_at: :desc)

    render template: "item_templates/index"
  end

  # keep your other actions (new, create, show, etc.) below…


  def new
    @item = Item.new
    render template: "item_templates/new"
  end

  def show
    the_id = params.fetch("path_id")
    matching_items = Item.where(id: the_id)
    @the_item = matching_items.at(0)

    render template: "item_templates/show"
  end

  def create
    the_item = Item.new
    the_item.name     = params[:item][:name]
    the_item.category = params[:item][:category]
    the_item.color    = params[:item][:color]
    the_item.user_id  = current_user.id

    # Attach uploaded image (if you're using ActiveStorage)
    if params[:item][:image_file].present?
      the_item.image.attach(params[:item][:image_file])
    end

    if the_item.save
      redirect_to "/items", notice: "Item created successfully."
    else
      @item = the_item
      render template: "item_templates/new"
    end
  end


  def update
    the_id = params.fetch("path_id")
    the_item = Item.where({ :id => the_id }).at(0)

    the_item.name = params.fetch("query_name")
    the_item.category = params.fetch("query_category")
    the_item.color = params.fetch("query_color")
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
