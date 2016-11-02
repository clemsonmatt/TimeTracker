Rails.application.routes.draw do
    resources :person,
        :landing,
        :sessions,
        :entry

    # entries
    get '/entries/:id/pause' => 'entry#pause', as: 'pause_entries'

    root 'landing#index'

    # session
    get 'signup', to: 'users#new', as: 'signup'
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
