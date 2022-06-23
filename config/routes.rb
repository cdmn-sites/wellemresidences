Rails.application.routes.draw do
  class AccountDomain  
    def self.matches?(request)
      ActiveRecord::Base.connection_pool.with_connection do
        Current.account = Spina::Account.find_by(domain: request.host) || Spina::Account.find_by(subdomain: request.subdomain)
      end
    end
  end

  constraints AccountDomain do
    resources :forms
    scope module: 'spina' do
      namespace :admin, path: Spina.config.backend_path do
        resources :room_types
      end
    end
    mount Spina::Engine => '/'
  end
end
