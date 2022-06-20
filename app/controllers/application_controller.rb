class ApplicationController < ActionController::Base
  before_action :set_active_storage
  before_action :get_locale

  inertia_share do 
    {
      account: Current.account,
      spina: spina_content,
      header_menu: Spina::Navigation.find_by(name: 'header')&.navigation_items&.map { |i| {path: i.materialized_path, label: i.menu_title || "[#{I18n.locale.to_s.upcase} MISSING]"}} || [],
      footer_menu: Spina::Navigation.find_by(name: 'footer')&.navigation_items&.map { |i| {path: i.materialized_path, label: i.menu_title || "[#{I18n.locale.to_s.upcase} MISSING]"}} || [],
    } 
  end

  def get_locale
    if params[:locale].present?
      I18n.locale = params[:locale]
      cookies[:locale] = params[:locale]
    elsif cookies[:locale].present?
      I18n.locale = cookies[:locale]
    elsif request.env['HTTP_ACCEPT_LANGUAGE']
      I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  end

  def spina_content
    @spina_content ||= {}.tap { |content| 
      for part in Current.account.json_attributes['en_content']
        content[part.attributes['name']] ||= part.attributes
      end
      for part in Current.account.json_attributes["#{I18n.locale}_content"]
        content[part.attributes['name']] ||= part.attributes
      end unless I18n.locale == 'en'
    }
  end

  def set_active_storage
    ActiveStorage::Current.url_options= { host: request.host_with_port }
  end

end
