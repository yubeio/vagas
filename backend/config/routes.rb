# frozen_string_literal: true

Rails.application.routes.draw do
  resources :companies, only: %i[index show create update destroy], shallow: true do
    collection do
      get 'with_deleted'
    end

    resources :company_processes, only: %i[index show create update destroy], path: 'process' do
      member do
        post 'update_status'
      end
    end
  end
end
