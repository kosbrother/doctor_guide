Rails.application.routes.draw do
  root "hello_world#index"
  
  namespace :api do
    get 'status_check' => 'api#status_check'
    namespace :v1 do
      resources :categories, :only => [:index]
    end
  end
end
