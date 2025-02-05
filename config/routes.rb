Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/healthz' => 'health#index'


  namespace :admin, path: '_adminz' do
    resources :venues
  end


  namespace :invitations do
    scope :books do
      get '/' => 'books#index'
      get '/:id' => 'books#show'
    end
  end
end
