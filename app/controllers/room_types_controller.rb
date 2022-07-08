class RoomTypesController < Spina::ApplicationController
  # include Spina::Frontend
  def show
    room_type = RoomType.find(params[:id])
    next_room_type = RoomType.where('position > ?', room_type.position).order('position asc').first
    prev_room_type = RoomType.unscoped.where('position < ?', room_type.position).order('position desc').first
    render inertia: 'room_type', props: {
      room_type: room_type.as_json(methods: [:images_prop, :thumbnails]),
      next_room_type: next_room_type.try(:as_json),
      prev_room_type: prev_room_type.try(:as_json)
    }
  end
end