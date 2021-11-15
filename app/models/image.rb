class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :user
  has_many :image_tags, dependent: :destroy
  has_many :tags, through: :image_tags
  validates :name, presence: true
  validates :file, file_size: { less_than_or_equal_to: 1.megabytes },
                   file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }

  scope :sort_by_name_asc, -> { order(name: :asc) }
  scope :sort_by_name_desc, -> { order(name: :desc) }
  scope :search_by, ->(keyword) { where('LOWER(name) LIKE ?', "%#{keyword}%") }

  def self.add_pagenation(param)
    page(param).per(10)
  end

  def self.sort_by_order(order)
    order == 'desc' ? sort_by_name_desc : sort_by_name_asc
  end
end
