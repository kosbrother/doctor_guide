Rails.application.routes.draw do
  root "hello_world#index"
  
  namespace :api do
    get 'status_check' => 'api#status_check'
    namespace :v1 do
      resources :areas, :only => [:index]
      resources :categories, :only => [:index]
      resources :hospitals,:only => [] do
        collection do
          get 'by_area_category'
        end
      end
      resources :doctors,:only => [] do
        collection do
          get 'by_area_category'
        end
      end
      resources :divisions,:only => [] do
        collection do
          get 'by_hospital_category'
          get 'by_hospital'
        end
      end
    end
  end
end
