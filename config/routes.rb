Rails.application.routes.draw do

  devise_for :members, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :member do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/search' => "searches#search"
    resources :reports, only: [:index, :show, :update] do
      resources :report_comments, only: [:create, :destroy]
    end
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items
    resources :members, only: [:index, :show, :update, :edit]
    resources :boards, only: [:show, :destroy] do
      resources :posts, only: [:show, :destroy]
    end
  end

  scope module: :public do
    root 'homes#top'
    get '/about_before' => "homes#about_before"
    get '/about' => "homes#about"
    get '/search' => "searches#search"
    resources :members, only: [:show, :edit, :update, :index] do
      resources :reports, only: [:new, :create]
      resources :notifications, only: [:index]
      resource :relationships, only: [:create, :destroy]
  	  get 'friends' => 'members#friends'
  	  get 'my_favorites' => 'members#my_favorites'
  	  get 'member_boards' => 'members#member_boards'
  	  get 'member_posts' => 'members#member_posts'
    end
    get 'boards/tag_index'
    resources :boards, only: [:index, :show, :new, :create] do
      resources :posts, only: [:show, :create] do
        resource :favorites, only: [:create, :destroy]
        resource :unlikes, only: [:create, :destroy]
      end
    end
    get 'posts/index'
    resources :items, only: [:index, :show] do
      resources :orders, only: :create
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
