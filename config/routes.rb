Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: {sessions: 'devise/citizen/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#home'
  get '/tweets', to: 'static#tweets'

  namespace :'padawan' do
    get '/home', to: 'padawan#home'
  end

  namespace :guardian do

  end

  namespace :manager do
    get '/home', to: 'managers#home'
    resources :districts
    resources :citizens
    resources :questionnaires
    resources :food
    resources :water
  end

end
