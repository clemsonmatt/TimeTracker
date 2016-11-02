Rails.application.routes.draw do
  get 'entry/new'

  get 'sessions/new'

    resources :person,
        :landing,
        :sessions,
        :entry

    root 'landing#index'

    get 'signup', to: 'users#new', as: 'signup'
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
