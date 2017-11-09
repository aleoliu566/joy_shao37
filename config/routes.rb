Rails.application.routes.draw do

  namespace :enterprise do
    resources :companies do
      resources :jobs
      resources :articles
    end
  end

  namespace :admin do
    resources :companies do
      member do
        post :ban
      end
      resources :jobs
    end

    resources :articles
    resources :users
    patch 'set_admin', :to => 'users#set_admin'
  end

  # 後台首頁
  get 'home', :to => 'admin/companies#home'
  get 'article', :to => 'admin/articles#say'
  devise_for :users

  resources :resumes, only: [:index, :new, :create, :destroy]
  resources :jobs

  root 'companies#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
