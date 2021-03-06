class RoomType < ApplicationRecord
  translates :description, :details, :kitchen, :laundry, :bathroom, :entertainment, :communication, :other

  default_scope -> { order('position asc')}

  after_save :clear_cache

  has_many_attached :images do |attachment|
    attachment.variant :thumb, resize_to_limit: [700,394]
    attachment.variant :preview, resize_to_limit: [1920,1080]
  end

  def clear_cache
    Rails.cache.clear('room_types_prop')
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

  def thumbnails
    images.attached? && images.map { |image|
      image.analyze unless image.metadata['width']
      processed = image.variant(:thumb).processed
      {
        url: processed.url,
        w: image.metadata['width'],
        h: image.metadata['height']
      } 
    }
  end
end
