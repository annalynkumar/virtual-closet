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

    # Load only this user's items
    items = current_user.items.order(:created_at)

    # Group by category
    grouped = items.group_by(&:category)

    # Reorder based on your custom category sequence
    @items_grouped_by_category = desired_order.map do |cat|
      [cat, grouped[cat] || []]
    end.to_h
  end
end
