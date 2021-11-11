class Tag < ApplicationRecord
  belongs_to :user
  has_many :image_tags, dependent: :destroy
  has_many :images, through: :image_tags
end
