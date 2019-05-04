Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/login', to: 'users#login'
  namespace 'api' do
    resources :source_providers, only: %i[index show]
    get '/courses', to: 'course_results#index'
    get '/courses/history', to: 'course_results#history'
  end
end
