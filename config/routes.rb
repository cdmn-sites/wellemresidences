Rails.application.routes.draw do
  # root "categories#index"
  
  class AccountDomain  
    def self.matches?(request)
      Current.account = Spina::Account.find_by(domain: request.host) || Spina::Account.find_by(subdomain: request.subdomain)
    end
  end

  constraints AccountDomain do
    scope module: 'spina' do
      namespace :admin, path: Spina.config.backend_path do
        resources :room_types
      end
    end
    mount Spina::Engine => '/'
  end
end
