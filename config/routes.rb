Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "items#index"

  resources :items, only: [:index, :new, :create, :destroy] do
    member do 
      put :restore
    end
  end
end
