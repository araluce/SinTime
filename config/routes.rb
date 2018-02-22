Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: {sessions: 'devise/citizen/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#home'
  get '/tweets', to: 'static#tweets'

  namespace :padawan do
    get '/home', to: 'padawan#home'
    get 'padawan_info', to: 'padawan_info#padawan_info'
    get 'formacion', to: 'formacion#formacion'
    get 'viveres', to: 'viveres#viveres'

    namespace :viveres do
      resources :print_exercise, only: :show, format: :js
      resources :food, only: :index
      resources :water, only: :index
    end

    namespace :padawan_info do
      resources :information, only: [:edit, :update]
    end

    namespace :formacion do
      get 'seguimiento', to: 'seguimiento#seguimiento'
      get 'mochila/:backpack_type', to: 'seguimiento#mochila', as: :mochila

      get 'guardar_texto/:tweet_id',       to: 'seguimiento#guardar_texto',       as: :guardar_texto
      get 'guardar_audiovisual/:tweet_id', to: 'seguimiento#guardar_audiovisual', as: :guardar_audiovisual
      get 'guardar_herramienta/:tweet_id', to: 'seguimiento#guardar_herramienta', as: :guardar_herramienta
      get 'guardar_compartido/:tweet_id',  to: 'seguimiento#guardar_compartido',  as: :guardar_compartido

      get 'follow_user', to: 'seguimiento#seguimiento'
      post 'follow_user', to: 'seguimiento#follow_user'
      patch 'load_tweeter_tweets', to: 'seguimiento#load_tweeter_tweets'
    end
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
