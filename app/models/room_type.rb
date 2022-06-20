class RoomType < ApplicationRecord  
  has_many_attached :images do |attachment|
    attachment.variant :thumb, resize_to_limit: [600,600]
    attachment.variant :preview, resize_to_limit: [1920,1080]
  end

  def thumbnail_url
    images.attached? && images.first.variant(:thumb).processed.url
  end

  def preview_url
    images.attached? && images.first.variant(:preview).processed.url
  end

  def images_prop
    images.attached? && images.map { |image| {url: image.variant(:preview).processed.url} }
  end
end
