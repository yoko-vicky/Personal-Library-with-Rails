module ImagesHelper
  def file_size(image)
    (image.file.size / 1000).floor(1)
  end

  def image_tags_list(image)
    image.tags.pluck(:name)
  end

  def image_tags_num(image)
    image.tags.count
  end

  def all_images_num(images)
    images.count
  end

  def file_required(type)
    type == 'Upload'
  end
end
