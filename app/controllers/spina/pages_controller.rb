class Spina::PagesController < Spina::ApplicationController
  include Spina::Frontend

  before_action :authorize_page
  before_action :merge_page_content

  def show
    template = page.view_template
    theme = current_tenant.preferences[:theme]
    render inertia: "#{theme}/#{template}"
  end

  private
    def merge_page_content
      for part in page.json_attributes['en_content']
        spina_content[part.attributes['name']] ||= part.attributes
      end
      spina_content['page_title'] = page.seo_title
      spina_content['page_description'] = page.description
    end

    def authorize_page
      raise ActiveRecord::RecordNotFound unless page.live? || logged_in?
    end

end