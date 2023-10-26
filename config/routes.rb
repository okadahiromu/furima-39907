Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  
  resources :items do
    resources :buyers, only: [:create, :index, :new]
    resources :orders, only: [:create, :index, :new]
  end   
end
