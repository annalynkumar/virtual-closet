class AddImageToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :image, :string
  end
end
