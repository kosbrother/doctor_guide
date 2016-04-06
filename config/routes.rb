Rails.application.routes.draw do

  root "index#index"

  get '/hospitals/recommend', to: 'hospitals#recommend'
  get '/hospitals/popular', to: 'hospitals#popular'
  get '/doctors/recommend', to: 'doctors#recommend'
  get '/doctors/popular', to: "doctors#popular"


  resources :areas, only: [:show] do
    resources :categories, only: [:show]
  end
  resources :categories, only: [:show]
  resources :hospitals, only: [:show] do
    resources :comments, only: [:new, :create]
    resources :divisions, only: [:show] do
      resources :comments, only: [:show, :new, :create]
      resources :doctors, only: [:show] do
        resources :comments, only: [:show, :new, :create]
      end
    end
  end

  post 'search', to: 'search#search'
  get '/search', to: 'search#search'

  get '/areas/:id/hospitals/recommend', to: 'hospitals#area_recommend', as: 'area_hospitals_recommend'
  get '/areas/:id/hospitals/popular', to: 'hospitals#area_popular', as: 'area_hospitals_popular'
  get '/areas/:id/doctors/recommend', to: 'doctors#area_recommend', as: 'area_doctors_recommend'
  get '/areas/:id/doctors/popular', to: 'doctors#area_popular', as: 'area_doctors_popular'
  get '/areas/:area_id/categories/:id/doctors/recommend', to: 'doctors#area_categories_recommend', as: 'area_category_doctors_recommend'
  get '/areas/:area_id/categories/:id/doctors/popular', to: 'doctors#area_categories_popular', as: 'area_category_doctors_popular'
  get '/categories/:id/doctors/recommend', to: 'doctors#categories_recommend', as: 'category_doctors_recommend'
  get '/categories/:id/doctors/popular', to: 'doctors#categories_popular', as: 'category_doctors_popular'
  get '/hospitals/:id/doctors/recommend', to: 'doctors#hospital_recommend', as: 'hospital_doctors_recommend'
  get '/hospitals/:id/doctors/popular', to: 'doctors#hospital_popular', as: 'hospital_doctors_popular'

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
    resources :users, only: [:index]
  end

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
