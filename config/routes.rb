Rails.application.routes.draw do

  root "homes#index" #説明ページがrootパス
  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'   
  } 

devise_scope :user do
  get "user/:id", :to => "users/registrations#detail"
  get "signup", :to => "users/registrations#new"
  get "login", :to => "users/sessions#new"
  get "logout", :to => "users/sessions#destroy"
end
  resources :users, :only => [:index,:show,:autocall]
   get 'users/index'
   get 'users/show'
   get 'users/autocall/:id' => "users#autocall"
   get 'users/stop_autocall/:id' => "users#stop_autocall"
  # devise_for :users

  ## 開発環境用letter_opener
  # mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end