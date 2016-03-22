Rails.application.routes.draw do
  
  get 'comment/doctor'

  get 'comment/category'

  get 'hospitals/:hospital', to: 'information#hospital', as: :hospital

  get 'divisions/:hospital/:division', to: 'information#division', as: :division

  get 'doctors/:hospital/:division/:doctor', to: 'information#doctor', as: :doctor

  get 'doctors/:doctor', to: 'information#doctorId', as: :doctor_id

  get 'search/byAreaCategory'

  get 'areas/:area', to: 'search#byArea', as: :area

  get 'search/byCategory'

  get 'search/result', to: 'search#search'

  get 'index/index'

  namespace :admin do
    get '/' => 'admin#index'
    get 'search_doctors', to: 'search#search_doctors'
    get 'search_hospitals', to: 'search#search_hospitals'
    resources :doctors
    resources :divisions
    resources :divisions
    resources :hospitals
    resources :comments
    resources :feedbacks, only: [:index]
    resources :problems, only: [:index]
    resources :add_doctors, only: [:index]
  end

  root "index#index"

  namespace :api do
    get 'status_check' => 'api#status_check'
    namespace :v1 do
      get 'search_doctors/:q' => 'search#search_doctors'      
      get 'search_hospitals/:q' => 'search#search_hospitals'
      resources :add_doctors, :only => [:create]
      resources :feedbacks, :only => [:create]
      resources :problems, :only => [:create]
      resources :users, :only => [:create]
      resources :comments,:only => [:show,:create,:update] do
        collection do
          get 'user_comments'
        end
      end
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
          get 'by_area'
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
          get 'by_area'
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
