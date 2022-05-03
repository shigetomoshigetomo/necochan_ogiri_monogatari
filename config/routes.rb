Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :reports, only: [:index, :show, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items
    resources :members, only: [:index, :show, :update]
  end

  namespace :public do
    get 'reports/new'
  end

  devise_scope :member do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :members, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root 'homes#top'
    get 'homes/about'
    get 'homes/index'
    resources :members, only: [:show, :edit, :update, :index] do
      resource :relationships, only: [:create, :destroy]
  	  get 'followings' => 'relationships#followings'
  	  get 'followers' => 'relationships#followers'
    end
    resources :boards, only: [:index, :show, :new, :create] do
      resources :posts, only: [:show, :index, :create] do
        resource :favorites, only: [:create, :destroy]
      end
    end
    resources :items, only: [:index, :show] do
      resources :orders, only: :create
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
