class RoomTypesController < Spina::ApplicationController
  # include Spina::Frontend
  def show
    
    room_type = RoomType.find(params[:id])
    render inertia: 'room_type', props: {
      room_type: room_type.as_json(methods: [:images_prop])
    }
  end
end