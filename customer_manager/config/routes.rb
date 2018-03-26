Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do
  		resources :customers
  		resources :procedures

      get '/customers/:id/procedures', to: 'customers#get_procedures'
  		get '/procedures/:id/approve', to: 'procedures#approve'
  		get '/procedures/:id/refuse', to: 'procedures#refuse'
  	end
  end

  post 'authenticate', to: 'authentication#authenticate'
end
