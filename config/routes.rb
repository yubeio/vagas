Rails.application.routes.draw do

  root to: 'home#index'
  resources :clients do
    post 'archived', to: 'clients#archived'
    resources :proccesses do
      post 'aproved', to: 'proccesses#aproved'
      post 'rejected', to: 'proccesses#rejected'
    end
  end
end
