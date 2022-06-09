Rails.application.routes.draw do
  # root "categories#index"
  mount Spina::Engine => '/'
end
