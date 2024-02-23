Rails.application.routes.draw do
  devise_for :users
  resources :items do
    resources :orders, only: [:index, :create]
  end
  root "items#index"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
