Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'links#new'
  get '/s/:slug', to: 'links#show', as: :short
  resources :links, only: %i[index new create]
end
