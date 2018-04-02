Rails.application.routes.draw do
  resources :companies, only: [:index, :show, :create, :update, :destroy]
end
