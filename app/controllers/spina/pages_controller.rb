class Spina::PagesController < Spina::ApplicationController
  include Spina::Frontend

  before_action :authorize_page
  before_action :merge_page_content

  def show
    if should_skip_to_first_child?
      redirect_to first_live_child.try(:materialized_path) and return
    elsif page.link_url.present?
      redirect_to Spina::Current.page.link_url and return
    end

    render inertia: page.view_template
  end

  def homepage
    render inertia: page.view_template, props: {
      room_types: Rails.cache.fetch("room_types_prop", expires_in: 12.hours) do
        RoomType.with_attached_images.as_json(methods: [:images_prop, :thumbnail_url, :thumbnails])
      end
    }
  end

  private
    def merge_page_content
      for part in page.json_attributes['en_content']
        spina_content[part.attributes['name']] = part.attributes
      end
      for part in page.json_attributes["#{I18n.locale}_content"]
        spina_content[part.attributes['name']] = part.attributes
      end unless I18n.locale == 'en'
      spina_content['page_title'] = page.seo_title
      spina_content['page_description'] = page.description
    end

    def authorize_page
      raise ActiveRecord::RecordNotFound unless page.live? || logged_in?
    end

end