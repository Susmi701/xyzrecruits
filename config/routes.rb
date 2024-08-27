Rails.application.routes.draw do

  root to: "home#index"
  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'
  resources :jobs, only: [:index, :show] do
    member do
      get 'apply'
      post 'submit_application'
      get 'confirm'
    end
  end
  
devise_for :users, controllers: {
  passwords: 'passwords'
} 
  resources :inquiries, only: [:create]

  namespace :admin do
    root 'dashboard#index'
    resource :page_contents, only: [:edit, :update]
    resource :contacts, only: [:edit, :update]
    resources :inquiries, only: [:index]
    resources :users, only: [:index, :new, :create, :destroy]
    resources :skills
    resources :categories
    resources :jobs do
      resources :applications, only: [] do
        member do
          patch 'shortlist', to: 'applications#shortlist', as: :shortlist
          patch 'reject', to: 'applications#reject', as: :reject
        end
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
