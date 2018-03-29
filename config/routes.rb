Rails.application.routes.draw do
  resources :clients do
    resources :client_processes
  end
end
