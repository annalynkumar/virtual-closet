class ItemsController < ApplicationController
  def index
    # form at the top of the page needs a fresh Item object
    @item = Item.new

    matching_items = Item.all
    @list_of_items = matching_items.order(created_at: :asc)

    render template: "item_templates/index"
  end

  # keep your other actions (new, create, show, etc.) below…


  def new
  @item = Item.new
  @list_of_items = Item.order(created_at: :desc) # ← Add this line
  render template: "item_templates/new"
end


def show
  @item = Item.find_by(id: params[:id])
  unless @item
    redirect_to items_path, alert: "Item not found."
  end
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
  @item = current_user.items.find(params[:id])

  @item.name = params[:item][:name]
  @item.category = params[:item][:category]
  @item.color = params[:item][:color]

  if params[:item][:image_file].present?
    @item.image.attach(params[:item][:image_file])
  end

  if @item.save
    redirect_to item_path(@item), notice: "Item updated!"
  else
    render :edit
  end
end

def edit
  @item = Item.find(params[:id])
end

  def destroy
    the_id = params.fetch("path_id")
    the_item = Item.where({ :id => the_id }).at(0)

    the_item.destroy

    redirect_to("/items", { :notice => "Item deleted successfully." } )
  end
end

def item_params
  params.require(:item).permit(:name, :category)
end 

