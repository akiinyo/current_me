Dummy::Application.routes.draw do
  root to: 'sessions#new'
  resources :users, only: %w(new create show)
  resources :sessions, only: %w(new create destroy)
  resources :rooms, only: %w(index)
end
