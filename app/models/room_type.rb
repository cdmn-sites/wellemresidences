class RoomType < ApplicationRecord
  #belongs_to Spina::Account
  
  has_many_attached :images do |attachment|
    attachment.variant :thumb, resize_to_limit: [600,600]
  end

  def image_url
    images.attached? && images.first.variant(:thumb).processed.url
  end
end
