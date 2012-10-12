Lingo::Application.routes.draw do
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'signout', to:'sessions#delete'
  resources :users, :only => :show

  resources :projects, :only => [:show,:index,:new,:create] do
    resources :pages, :only => [:show,:new,:create,:edit,:update]
  end
  resources :translations, :only => [:new,:create,:update]

  get 'welcome' => 'projects#index'
  root :to => 'projects#index'
end
