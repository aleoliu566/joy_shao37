Rails.application.routes.draw do
  namespace :enterprise do
    resources :companies do
      resources :jobs
    end
  end

  devise_for :users

  root 'companies#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
