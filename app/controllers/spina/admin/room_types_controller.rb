module Spina::Admin
  class RoomTypesController < AdminController
    before_action :set_room_type, only: [:edit]
    before_action :set_locale
    
    admin_section :content

    def index
      @room_types = RoomType.all.page(params[:page]).per(25)
    end

    def edit
      add_breadcrumb 'Room Types', Rails.application.routes.url_helpers.admin_room_types_path
      add_breadcrumb @room_type.name
    end

    def update
      if params[:room_types]
        for id, index in params[:room_types].each_with_index
          RoomType.find(id).update position: index
        end
      end
      @room_type = RoomType.find(params[:id])
      I18n.locale = params[:locale]
      if @room_type.update(room_type_params)
        params[:room_type][:images].each_with_index do |sid, i|
          next unless sid.class == String && sid.present?
          blob = ActiveStorage::Blob.find_signed(sid)
          blob.attachments.update_all position: i
        end if params[:room_type][:images]
        # redirect_to spina.edit_admin_layout_path(locale: @locale), flash: {success: t('spina.layout.saved')}
        redirect_back fallback_location: spina.edit_admin_layout_path(locale: @locale), flash: {success: 'Room Type Saved'}
      else
        flash.now[:error] = t('room_type.couldnt_be_saved')
        render partial: 'error', status: :unprocessable_entity
      end
    end

    private
    
      # Permit all attributes when editing your layout
      def room_type_params
        params.require(:room_type).permit!
      end
      
      def set_breadcrumb
        add_breadcrumb t('room types')
      end

      def set_room_type
        @room_type = RoomType.find(params[:id])
      end

      def set_locale
        @locale = params[:locale] || I18n.locale
      end

  end
end