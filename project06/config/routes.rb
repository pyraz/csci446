Gamez::Application.routes.draw do

  resources :user_sessions, :only => [:new, :create, :destroy]
  resources :games
  resources :users, :only => [:new, :create]

  match '/login' => 'user_sessions#new', :as => :login
  match '/logout' => 'user_sessions#destroy', :as => :logout
  match '/register', :controller => 'users', :action => 'new',
      :as => :register

  root :to => "games#index"

  namespace :admin do
    resources :users
    resources :roles
    resources :games
    root :controller => 'games', :action => 'index'
  end

  namespace :members do
    resources :games
    resources :users
    match '/profile', :controller => 'users', :action => 'show', 
      :as => :profile
    match '/profile/edit', :controller => 'users', :action => 'edit',
      :as => :edit_profile
    match '/profile/:id', :controller => 'users', :action => 'update',
      :as => :update_profile
    root :controller => 'games', :action => 'index'
  end
  
end
