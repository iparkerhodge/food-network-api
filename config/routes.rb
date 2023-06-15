Rails.application.routes.draw do
  resources :api_keys, path: 'api-keys', only: %i[index create destroy]

  post 'sign-up', to: 'users#create'
  post 'login', to: 'users#index'
end
