# frozen_string_literal: true

Rails.application.routes.draw do
  resources :companies, only: %i[index show create update destroy]
  get 'companies_with_deleted', to: 'companies#index_with_deleted'
end
