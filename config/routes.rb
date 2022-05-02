Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :reports, only: [:index, :show, :update]
    resources :genres, only: [:index, :new, :create, :edit, :update]
    resources :items, only: [:index, :show, :edit, :new, :create]
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
    resources :members, only: [:show, :edit, :update, :index]
    resources :boards, only: [:index, :show, :new, :create]
    resources :posts, only: [:show, :index, :create]
    resources :items, only: [:index, :show]
  end

  # devise_scope :member do
  #   post 'members/guest_sign_in', to: 'members/sessions#guest_sign_in'
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
