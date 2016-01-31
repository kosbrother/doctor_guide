Rails.application.routes.draw do
  resources :doctors
  resources :divisions
  resources :divisions
  resources :hospitals
  resources :comments
  root "hello_world#index"
  
  namespace :api do
    get 'status_check' => 'api#status_check'
    namespace :v1 do
      resources :users, :only => [:create]
      resources :comments,:only => [:show,:create,:update]
      resources :areas, :only => [:index]
      resources :categories, :only => [:index]
      resources :hospitals,:only => [:show] do
        resources :comments,:only => [:index]
        member do
          get 'score'
          get 'divisions_with_doctors'
        end 
        collection do
          get 'by_area_category'
        end
      end
      resources :doctors,:only => [:show] do
        resources :comments,:only => [:index]
        member do
          get 'score'
        end 
        collection do
          get 'by_area_category'
          get 'by_hospital_division'
        end
      end
      resources :divisions,:only => [] do
        resources :comments,:only => [:index]
        member do
          get 'score'
        end
        collection do
          get 'by_hospital_category'
          get 'by_hospital'
        end
      end
    end
  end
end
