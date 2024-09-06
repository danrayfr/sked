Rails.application.routes.draw do
  root "organizations#index"

  resource :first_run, only: %i[show create], path: "setup"

  resources :users do
    scope module: "users" do
      resource :profile
    end
  end

  get "/dashboard", to: "home#show"

  resource :session
  resources :passwords, param: :token

  get "organization/:uid/join/:join_code", to: "users#new", as: :join
  post "organization/:uid/join/:join_code", to: "users#create"

  resources :organizations, except: %i[ index show ] do
    scope module: "organizations" do
      resource :join_code, only: :create
    end
    resources :patient_records, except: %i[ index new show edit ]
  end

  get "/:uid/:slug", to: "organizations#show", constraints: { uid: /\d+/ }, as: :slugged_organization

  get "/organization/:uid/patient_records", to: "patient_records#index", constraints: { uid: /\d+/ }, as: :slugged_organization_patient_records
  get "/organization/:uid/patient_records/new", to: "patient_records#new", constraints: { uid: /\d+/ }, as: :slugged_new_organization_patient_records
  get "/organization/:uid/patient_records/:id", to: "patient_records#show", constraints: { uid: /\d+/ }, as: :slugged_organization_patient_record
  get "/organization/:uid/patient_records/:id/edit", to: "patient_records#edit", constraints: { uid: /\d+/ }, as: :slugged_edit_organization_patient_record

  # get "/:slug", to: "organizations#show", as: :slugged_organization

  direct :organization_slug do |organization, options|
    route_for :slugged_organization, organization.uid, organization.slug, options
  end

  get "up", to: "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest
end
