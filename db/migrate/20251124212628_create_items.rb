class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.string :color
      t.string :image_url
      t.integer :user_id

      t.timestamps
    end
  end
end
