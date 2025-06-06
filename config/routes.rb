Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/healthz' => 'health#index'
  get '/error' => 'error#index', as: 'error'

  # set redirector root to /invitations/books
  root to: redirect('/invitations/books')

  # modify devise path_names to avoid clash with existing
  devise_for :users, path: '_auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

  namespace :admin, path: '_adminz' do

    # home controller, only display index and error. no resources
    get '/' => 'home#index', as: 'root'
    get '/error' => 'home#error', as: 'error'

    resources :venues
    resources :weddings
    resources :invitations
    resources :guests

    resources :users do
      patch '/confirm' => 'users#confirm', as: 'confirm'
      patch '/revoke' => 'users#revoke', as: 'revoke'
    end
  end

  namespace :invitations do
    scope :books do
      get '/' => 'books#index'
      get '/:id' => 'books#show', as: 'show'

      post '/:id' => 'books#create', as: 'create'
    end
  end
end
