class ImageTag < ApplicationRecord
  belongs_to :image
  belongs_to :tag
  belongs_to :user
end
