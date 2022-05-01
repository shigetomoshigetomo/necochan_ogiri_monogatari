Rails.application.routes.draw do
  namespace :public do
    get 'boards/index'
    get 'boards/show'
    get 'boards/new'
  end
  namespace :admin do
    get 'reports/index'
  end
  namespace :admin do
    get 'genres/index'
  end
  namespace :admin do
    get 'members/index'
    get 'members/show'
    get 'members/edit'
  end
  namespace :admin do
    get 'items/new'
    get 'items/index'
    get 'items/show'
    get 'items/edit'
  end
  namespace :public do
    get 'reports/new'
  end
  namespace :public do
    get 'posts/show'
    get 'posts/index'
  end
  namespace :public do
    get 'threads/index'
    get 'threads/new'
    get 'threads/show'
  end
  namespace :public do
    get 'items/index'
  end
  namespace :public do
    get 'members/show'
    get 'members/edit'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
    get 'homes/index'
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
