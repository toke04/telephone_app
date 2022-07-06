Rails.application.routes.draw do

  #説明ページがrootパス
  root "homes#index"  

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

  #独自に追加
  resources :users, :only => [:index,:show]
  get 'users/index'
  get 'users/show'
  get 'users/autocall/:id' => "users#autocall"
  get 'users/stop_autocall/:id' => "users#stop_autocall"
end