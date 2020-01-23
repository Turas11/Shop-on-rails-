Rails.application.routes.draw do

  resource :cart, controller: "cart", only: [:show, :update, :edit] do
    member do
      post :add_product
      post :remove_product
      get :confirmation
      post :finish
    end
  end



  namespace :admin do
    root to: 'products#index'
    resources :products
    resources :categories
    resources :orders, only: [:show, :index, :update]
  end

  get 'categories/show'
  get 'regulamin', to: "static#term", as: :terms
  get 'polityka-prywatnosci', to: "static#privacy", as: :privacy
  get 'dostawa', to: "static#shipping", as: :shipping
  get 'oo-sklepie', to: "static#about", as: :about

  root to: "products#index"
  resources :products, only: [:show, :index], path: "produkt"
  resources :categories, only: [:show], path: "kategoria"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
