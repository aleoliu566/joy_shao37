Rails.application.routes.draw do

  namespace :enterprise do
    resources :companies do
      resources :jobs
      resources :articles
      get 'record', :to => 'resumes#record'
    end
  end

  namespace :admin do
    resources :companies do
      member do
        post :ban
      end
      resources :jobs
    end

    resources :jobs, only:[:index]
    resources :articles do
      member do
        post :audit
      end
    end

    resources :tags

    resources :users
    patch 'set_admin', :to => 'users#set_admin'

    get 'record', :to => 'resumes#record'
  end

  # 後台首頁
  get 'home', :to => 'admin/companies#home'
  # get 'article', :to => 'admin/articles#say'
  devise_for :users

  resources :users do
    resources :resumes, only: [:index, :new, :create, :destroy]
    get 'record', :to => 'resumes#record'
    get 'collect', :to => 'companies#collect'
  end

  
  resources :jobs
  
  resources :articles

  root 'companies#home'

  resources :companies do
    resources :jobs do
      member do
        get :check_resume
        post :apply
      end
    end
  end

  resources :articles, only: [:show, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
