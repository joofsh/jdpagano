
Jdpagano::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'main#index'

  get 'login' => 'sessions#new', as: 'login'
  get 'logout' => 'sessions#destroy', as: 'logout'
  resources :sessions
  resources :articles, except: [:show]
  get 'articles/:slug' => 'articles#show'


  get '*path', to: 'main#missing'
end
