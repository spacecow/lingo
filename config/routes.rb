Lingo::Application.routes.draw do
  resources :projects, :only => [:show,:index,:new,:create] do
    resources :pages, :only => [:show,:new,:create]
  end
  resources :translations, :only => [:create]
  # root :to => 'welcome#index'
end
