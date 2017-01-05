Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    '/welcome', to: 'sessions#new',     as: :welcome
  post   '/login',   to: 'sessions#create',  as: :login
  delete '/logout',  to: 'sessions#destroy', as: :logout
  resources :users, only: [:new, :create]
end
