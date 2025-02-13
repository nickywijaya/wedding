Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/healthz' => 'health#index'

  # root to: "home#index"
  devise_for :users, path: '_auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

  namespace :admin, path: '_adminz' do
    resources :home

    resources :venues
    resources :weddings
    resources :invitations
    resources :guests
  end

  namespace :invitations do
    scope :books do
      get '/' => 'books#index'
      get '/:id' => 'books#show', as: 'show'
    end
  end
end
