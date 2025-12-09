class ClosetController < ApplicationController
  def index
    @item = Item.new

    desired_order = [
      "Tops",
      "Pants",
      "Skirts",
      "Dress",
      "Outerwear",
      "Shoes",
      "Accessories"
    ]

    # Read the selected color group from the params
    @selected_color_group = params[:color_group]

    color_groups = {
      "Neutrals"       => ["White", "Black", "Gray", "Beige", "Brown", "Cream", "Tan", "Khaki"],
      "Blues"          => ["Blue", "Navy", "Light Blue"],
      "Greens"         => ["Green", "Olive", "Mint"],
      "Warm Tones"     => ["Red", "Orange", "Yellow", "Maroon"],
      "Pinks/Purples"  => ["Pink", "Purple", "Lavender"],
      "Metallics"      => ["Gold", "Silver", "Bronze"],
      "Other"          => ["Multicolor", "Other"]
    }

    # Load only this user's items
    items = current_user.items.order(:created_at)

    # Filter by color if selected
    if @selected_color_group.present? && color_groups[@selected_color_group]
      items = items.where(color: color_groups[@selected_color_group])
    end

    # Group by category
    grouped = items.group_by(&:category)

    # Reorder based on your custom category sequence
    @items_grouped_by_category = desired_order.map do |cat|
      [cat, grouped[cat] || []]
    end.to_h

    @color_groups = color_groups.keys
  end
end
