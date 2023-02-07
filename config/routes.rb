Rails.application.routes.draw do
  
  devise_scope :user do
  root to: "devise/sessions#new"
end
  resources :products do
    resources :feedbacks
  end
  
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
