class CreateOutfits < ActiveRecord::Migration[8.0]
  def change
    create_table :outfits do |t|
      t.string :name
      t.string :occasion
      t.string :season
      t.integer :user_id

      t.timestamps
    end
  end
end
