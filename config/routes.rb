Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: {sessions: 'devise/citizen/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#home'

  namespace :citizen do
    get '/home', to: 'citizens#home'
  end

  namespace :guardian do

  end

  namespace :manager do
    get '/home', to: 'managers#home'
    resources :districts
    resources :citizens
  end

end
