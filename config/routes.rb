Rails.application.routes.draw do

  #説明ページをrootに
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

  resources :users, :only => [:index,:show]
  
  # 電話用
  get 'autocall' => "autocalls#autocall"
  get 'stop_autocall' => "autocalls#stop_autocall"
   
end