Rails.application.routes.draw do
  resources :recipes
  resources :api_keys, path: 'api-keys', only: %i[index create destroy]

  post 'intake', to: 'recipes#create'

  post 'sign-up', to: 'users#create'
  post 'login', to: 'users#index'
end
