Rails.application.routes.draw do

  scope module: :public do
    root 'homes#top'
    get 'homes/about'
    get 'homes/index'
    resources :members, only: [:show, :edit, :update]
    resources :boards, only: [:index, :show, :new, :create]
    resources :posts, only: [:show, :index, :create]
    resources :items, only: [:index, :show]
  end

  namespace :admin do
    resources :reports, only: [:index, :show, :update]
    resources :genres, only: [:index, :new, :create, :edit, :update]
    resources :items, only: [:index, :show, :edit, :new, :create]
    resources :members, only: [:index, :show, :update]
  end

  namespace :public do
    get 'reports/new'
  end

  devise_for :members, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
