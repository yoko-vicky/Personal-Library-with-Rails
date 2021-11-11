module TagsHelper
  def tag_images_num(tag)
    tag.images.count
  end
end
