Rails.application.routes.draw do
  root "todo#index"

  get '/todo/retrieve_data', to: 'todo#retrieve_data'
  resources :todo
end
