class ApplicationController < ActionController::Base
  helper_method :current_tenant

  inertia_share do 
    {
      tenant: current_tenant,
      spina: spina_content,
      menu: Spina::Navigation.first.navigation_items.map { |i| {path: i.materialized_path, label: i.menu_title}}
    } 
  end

  def spina_content
    @spina_content ||= {}.tap { |content| 
      for part in current_tenant.json_attributes['en_content']
        content[part.attributes['name']] ||= part.attributes
      end
    }
  end

  def current_tenant
    # TODO: use domain or subdomain to fetch account
    @tenant ||= Spina::Account.first
  end
end
