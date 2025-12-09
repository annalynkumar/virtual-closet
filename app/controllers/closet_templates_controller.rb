class ClosetController < ApplicationController
  def index
    items = current_user.items.order(:category, created_at: :asc)
    @items_grouped_by_category = items.group_by(&:category)

    render template: "closet_templates/index"
  end
end
