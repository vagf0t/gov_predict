
Rails.application.routes.draw do
  root 'dashboard#index'
  namespace :api do
    resources :posts, only: [:index] do
      get :search, on: :collection
    end
  end
end
