Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'source_providers#root'

  jsonapi_resources :source_providers, only: %i[index show]
  jsonapi_resources :users, only: %i[index show]
  get '/courses', to: 'course_results#index'
  get '/courses/history', to: 'course_results#history'
end
