Rails.application.routes.draw do
  get 'home/index'
  # get 'users/show'

  root to: 'home#index'

get 'home/about', to: "home#about"


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


resources :books, only: [:new, :create, :edit, :index, :show, :update, :destroy]
resources :users, only: [:show, :create, :edit, :update, :index, :destroy]

end
