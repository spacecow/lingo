Lingo::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'signout', to:'sessions#delete'
  resources :users, :only => :show

  resources :projects, :only => [:show,:index,:new,:create] do
    resources :pages, :only => [:show,:new,:create,:edit,:update]
  end
  resources :translations, :only => [:new,:create,:update]

  resources :sentence do
    resources :comments, :only => :create do
    end
  end

  get 'welcome' => 'projects#index'
  root :to => 'projects#index'
end
