Rails.application.routes.draw do
  root "products#index"

  resources :cart_items, only: :create
  resources :orders, only: %i[new create]

  namespace :erp, defaults: {format: :json} do
    resources :orders, only: :create
  end
end
