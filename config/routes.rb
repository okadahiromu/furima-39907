Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  root to: "items#index"

  resources :users, only: :index 
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
