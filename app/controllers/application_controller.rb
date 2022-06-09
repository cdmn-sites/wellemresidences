class ApplicationController < ActionController::Base
  helper_method :current_tenant

  inertia_share do 
    main_nav = Spina::MenuPresenter.new(Spina::Page.all)
    {
      tenant: current_tenant,
      spina: spina_content,
      main_nav: main_nav
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
    Spina::Account.first
  end
end
