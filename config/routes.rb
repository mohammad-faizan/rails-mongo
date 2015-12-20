Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
  	root 'devise/sessions#new'
  end
  # root 'posts#index'
  resources :posts do
  	resources :comments, only: [:create, :destroy]
  end
end
