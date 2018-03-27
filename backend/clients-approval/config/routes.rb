Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: {format: :json} do
        resources :client, only: [:index, :create, :update, :destroy, :show]
        get 'deleted_clients', to: 'client#clients_with_deleted'

        # process
        resources :client_process, only:[:index, :create, :update, :destroy]
    end
  end
end
