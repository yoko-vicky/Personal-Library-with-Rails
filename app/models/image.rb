class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :user
  has_many :image_tags, dependent: :destroy
  has_many :tags, through: :image_tags
end
