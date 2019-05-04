Rails.application.routes.draw do
  jsonapi_resources :source_providers, only: %i[index show]
  get 'courses', to: 'course_results#index'
  get 'courses/history', to: 'course_results#history'
end
