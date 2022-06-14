class ApplicationController < ActionController::Base
  before_action :set_active_storage
  helper_method :current_account

  inertia_share do 
    {
      account: current_account,
      spina: spina_content,
      header_menu: Spina::Navigation.find_by(name: 'header')&.navigation_items&.map { |i| {path: i.materialized_path, label: i.menu_title || "[#{I18n.locale.to_s.upcase} MISSING]"}} || [],
      footer_menu: Spina::Navigation.find_by(name: 'footer')&.navigation_items&.map { |i| {path: i.materialized_path, label: i.menu_title || "[#{I18n.locale.to_s.upcase} MISSING]"}} || [],
      
    } 
  end

  def spina_content
    @spina_content ||= {}.tap { |content| 
      for part in current_account.json_attributes['en_content']
        content[part.attributes['name']] ||= part.attributes
      end
      for part in current_account.json_attributes["#{I18n.locale}_content"]
        content[part.attributes['name']] ||= part.attributes
      end unless I18n.locale == 'en'
    }
  end

  def current_account
    # TODO: use domain or subdomain to fetch account
    @current_account ||= Spina::Account.first
  end

  def set_active_storage
    ActiveStorage::Current.url_options= { host: request.host_with_port }
  end

end
