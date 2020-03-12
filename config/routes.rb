Rails.application.routes.draw do
  root "homes#top"
  # get "home/top" => "homes#top", as: "top"
  get "home/about" => "homes#about", as: "about"
  devise_for :users
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
