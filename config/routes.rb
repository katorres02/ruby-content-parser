Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :pages, only: [:create, :index]
    end
  end

  resources :pages, only: [:index, :show]
end
