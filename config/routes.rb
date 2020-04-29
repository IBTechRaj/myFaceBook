Rails.application.routes.draw do
  get 'likes/create'
  #get 'comments/create'
  #get 'comments/edit'
  #get 'comments/update'
  #get 'comments/destroy'
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  resources :users, only: [:show,:index]
  #get 'users/index'
  #get 'users/show'
  # get 'posts/new'
  # get 'posts/create'
  # get 'posts/destroy'
  # get 'posts/update'
  # get 'posts/index'

as :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
    unauthenticated do
      root 'posts#index', as: :unauthenticated_root
    end
  end

# root to: 'users#index'
  
  
  # resources :posts do 
  #  resources :comments, :likes
  # end


  #resources :users, only: [:show,:index]
  #resources :posts, only: [:show, :create, :edit, :update, :destroy] do
  resources :posts do
    resources :comments, :likes
  end
  #get 'home/index'
  
  #get 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
