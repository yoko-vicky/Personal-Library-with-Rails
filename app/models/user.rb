class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :images, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :image_tags, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def images_sort_by(order)
    order == 'asc' ? images.sort_by_name_asc : images.sort_by_name_desc
  end

  def tags_num
    tags.count
  end

  def tags_sort_by(order)
    order == 'asc' ? tags.sort_by_name_asc : tags.sort_by_name_desc
  end

  def images_search_by(keyword)
    images unless keyword

    images.search_by(keyword) || images
  end

  def tags_search_by(keyword)
    tags unless keyword

    tags.search_by(keyword) || tags
  end

  def find_image_tags(tag_id, image_id)
    image_tags.where(tag_id: tag_id, image_id: image_id)[0]
  end
end
