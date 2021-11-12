class Tag < ApplicationRecord
  belongs_to :user
  has_many :image_tags, dependent: :destroy
  has_many :images, through: :image_tags

  scope :sort_by_name_asc, -> { order(name: :asc) }
  scope :sort_by_name_desc, -> { order(name: :desc) }

  def images_sort_by(order)
    order == 'asc' ? images.sort_by_name_asc : images.sort_by_name_desc
  end

  def self.add_pagenation(param)
    page(param).per(10)
  end
end
