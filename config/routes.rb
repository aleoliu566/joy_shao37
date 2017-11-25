Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  namespace :enterprise do
    resources :companies do
      resources :jobs
      post 'ban', :to => 'jobs#ban'
      resources :articles
      get 'record', :to => 'resumes#record'
    end

    patch ':company_id/set_hr', :to => 'companies#set_hr', :as => 'set_hr'
    patch ':id/:user_id/remove_hr', :to => 'companies#remove_hr', :as => 'remove_hr'

  end

  namespace :admin do
    resources :jobs
    resources :tags
    resources :users

    resources :companies do
      member do
        post :ban
      end
    end

    resources :jobs, only:[:index]
    resources :articles do
      member do
        post :audit
      end
    end

    patch 'set_admin', :to => 'users#set_admin'
    patch ':id/remove_admin', :to => 'users#remove_admin', :as => 'remove_admin'
    get 'record', :to => 'resumes#record'

    get 'analysis', :to => 'companies#analysis', :as => 'analysis'
  end

  # 後台首頁
  get 'home', :to => 'admin/companies#home'
  devise_for :users

  resources :users do
    resources :resumes, only: [:index, :new, :create, :destroy]
    get 'record', :to => 'resumes#record'
    get 'collect', :to => 'companies#collect'
  end

  resources :jobs do
    member do
       post :favorite
       post :unfavorite
    end
  end
  
   resources :articles do
    member do
       post :favorite
       post :unfavorite
    end
  end
  root 'companies#home'

  resources :companies do
    post :favorite
    post :unfavorite
    resources :jobs do
      member do
        get :check_resume
        post :apply
      end
    end
  end

  resources :articles, only: [:show, :index]

end
