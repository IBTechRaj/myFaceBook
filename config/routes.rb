Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  get 'posts/destroy'
  get 'posts/update'
  get 'posts/index'
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
