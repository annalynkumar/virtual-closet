# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  category   :string
#  color      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Item < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many   :outfit_items, class_name: "OutfitItem", foreign_key: "item_id", dependent: :destroy
  has_one_attached :image
end
