class ClosetController < ApplicationController
  def index
    @item = Item.new

    desired_order = [
      "Tops",
      "Pants",
      "Skirts",
      "Dresses",
      "Outerwear",
      "Shoes",
      "Accessories"
    ]

    @selected_color_group = params[:color_group]

    color_groups = {
      "No Filter" => [
  "White", "Black", "Gray", "Beige", "Brown", "Cream", "Tan", "Khaki",
  "Blue", "Navy", "Light Blue",
  "Green", "Olive", "Mint",
  "Red", "Orange", "Yellow", "Maroon",
  "Pink", "Purple", "Lavender",
  "Gold", "Silver", "Bronze",
  "Multicolor", "Other" ],
      "Neutrals"       => [ "White", "Black", "Gray", "Beige", "Brown", "Cream", "Tan", "Khaki" ],
      "Blues"          => [ "Blue", "Navy", "Light Blue" ],
      "Greens"         => [ "Green", "Olive", "Mint" ],
      "Warm Tones"     => [ "Red", "Orange", "Yellow", "Maroon" ],
      "Pinks/Purples"  => [ "Pink", "Purple", "Lavender" ],
      "Metallics"      => [ "Gold", "Silver", "Bronze" ],
      "Other"          => [ "Multicolor", "Other" ]
    }


    items = current_user.items.order(:created_at)


    if @selected_color_group.present? && color_groups[@selected_color_group]
      items = items.where(color: color_groups[@selected_color_group])
    end


    grouped = items.group_by(&:category)

    @items_grouped_by_category = desired_order.map do |cat|
      [ cat, grouped[cat] || [] ]
    end.to_h

    @color_groups = color_groups.keys
  end
end
