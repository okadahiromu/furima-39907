Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :orders do
    resources :buyers, only: :create :create
  end
  resources :items
end
