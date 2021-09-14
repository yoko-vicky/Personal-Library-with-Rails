class Tag < ApplicationRecord
  has_many :image_tags
  has_many :images, through: :image_tags
end
