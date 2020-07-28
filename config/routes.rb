Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  resources :post_images do
  	resources :post_comments, only: [:create, :destroy]
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
