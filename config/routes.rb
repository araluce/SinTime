Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/super_admin', as: 'rails_admin'
  devise_for :admins
  devise_for :users, controllers: {sessions: 'devise/citizen/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  get '/robots.:format' => 'static#robots'
  root 'static#home'
  get '/tweets', to: 'static#tweets'
  get '/register', to: 'static#register'
  post '/check_register', to: 'static#check_register', as: :check_register
  patch '/register_user', to: 'static#register_user', as: :register_user
  post 'get_messages', to: 'messages#get_messages'
  resources :messages

  namespace :padawan do
    get '/home', to: 'padawan#home'
    get 'padawan_info', to: 'padawan_info#padawan_info'
    get 'formacion', to: 'formacion#formacion'
    get 'viveres', to: 'viveres#viveres'
    get 'comunidad', to: 'comunidad#comunidad'
    get 'desconexion', to: 'desconexion#desconexion'

    namespace :viveres do
      resources :print_exercise, only: :show, format: :js
      resources :food, only: :index
      resources :water, only: :index
      resources :send_exercises, only: :update
      get 'purchase_exercise/:exercise_id', to: 'purchase_exercises#purchase', as: :purchase_exercise
      get 'rewind_exercise/:exercise_id', to: 'purchase_exercises#rewind', as: :rewind_exercise
    end

    namespace :padawan_info do
      resources :information, only: [:index, :edit, :update]
      resources :movimientos, only: :index
      resources :rango_jedi, only: :index
      resources :privileges_cards, only: [:index, :show] do
        resources :user_privileges_cards, only: :create
      end
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

    namespace :comunidad do
      get 'rci', to: 'rci#rci'
      get 'altruismo', to: 'altruismo#altruismo'
      resources :sports, only: :index
      resources :login, except: [:index, :destroy]
      resources :deteccion, only: [:index, :show] do
        resources :mis_apuestas, only: :create
      end
      namespace :rci do
        resources :sala, only: :index
        resources :chat_user, only: :show
        resources :chat_admin, only: :show
        resources :chat_general, only: :show
      end

      namespace :altruismo do
        resources :donations
      end
    end

    namespace :felicidad do
      resources :audiencia, only: [:index, :create, :update]
    end

    namespace :desconexion do
      resources :capsula_del_tiempo, only: [:index, :show, :create, :update] do
        get 'pay_all', to: 'capsula_del_tiempo#pay_all'
        get 'pay_share', to: 'capsula_del_tiempo@pay_share'
      end
      resources :retiro, only: [:index, :create]
    end
  end

  namespace :guardian do

  end

  namespace :manager do
    get '/home', to: 'managers#home'
    resources :districts do
      resources :banking_movements, only: :create
    end
    resources :citizens do
      resources :banking_movements, only: :create
      resources :user_deliveries, only: [:index, :edit, :update]
    end
    resources :padawan_registers, only: [:new, :create]
    resources :questionnaires
    resources :food
    resources :water
    resources :sports
    resources :happiness
    resources :privileges_cards, except: :new
    resources :scores
    resources :deliveries
    resources :constants, except: :show
    resources :ranges, except: :show
    resources :sala, only: :index
    resources :chat_admin, only: :show
    resources :holidays, only: [:index, :create]
    resources :bets, except: :new do
      get 'pay_and_close', to: 'bets#pay_and_close'
      get 'close', to: 'bets#close'
      get 'reopen', to: 'bets#reopen'
    end
  end

end
