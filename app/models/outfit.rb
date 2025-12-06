# == Schema Information
#
# Table name: outfits
#
#  id         :bigint           not null, primary key
#  name       :string
#  occasion   :string
#  season     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Outfit < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many   :outfit_items, class_name: "OutfitItem", foreign_key: "outfit_id", dependent: :destroy
end
