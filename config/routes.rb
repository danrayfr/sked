Rails.application.routes.draw do
  root "organizations#index"

  resource :first_run, only: %i[show create], path: "setup"

  resources :users do
    scope module: "users" do
      resource :profile
    end
  end

  resource :session
  resources :passwords, param: :token

  get "organization/:uid/join/:join_code", to: "users#new", as: :join
  post "organization/:uid/join/:join_code", to: "users#create"

  resources :organizations, param: :uid, except: %i[ index show ] do
    scope module: "organizations" do
      resource :join_code, only: :create
    end
    resources :patient_records
    resources :services
  end

  get "/:slug", to: "organizations#show", as: :slugged_organization

  get "organization/:uid/administratorships", to: "administratorships#index",  constraints: { uid: /\d+/ }, as: :slugged_organization_administratorships
  get "organization/:uid/administratorships/:id", to: "administratorships#index",  constraints: { uid: /\d+/ }, as: :slugged_organization_administratorship
  patch "organization/:uid/administratorships/:id", to: "administratorships#update", constraints: { uid: /\d+/ }

  get "up", to: "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest
end

