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

    template = page.view_template
    theme = current_tenant.preferences[:theme]
    render inertia: "#{theme}/#{template}"
  end

  def homepage
    template = page.view_template
    theme = current_tenant.preferences[:theme]
    render inertia: "#{theme}/homepage", props: {
      room_types: RoomType.all.as_json(methods: [:image_url])
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

    def page_by_locale(locale)
      I18n.with_locale(locale) do
        Spina::Page.i18n.find_by!(materialized_path: spina_request_path)
      end
    end

    def spina_request_path
      segments = [Spina.mounted_at, params[:id]].compact
      File.join(*segments)
    end

end