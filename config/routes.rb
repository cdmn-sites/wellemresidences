Rails.application.routes.draw do
  # root "categories#index"
  
  scope module: 'spina' do
    namespace :admin, path: Spina.config.backend_path do
      resources :room_types
    end
  end
  
  mount Spina::Engine => '/'
end
