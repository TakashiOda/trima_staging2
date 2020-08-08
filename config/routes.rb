Rails.application.routes.draw do

  get 'activity_businesses/index'
  get 'activity_businesses/show'
  get 'activity_businesses/new'
  get 'activity_businesses/edit'
  get 'businesses/index'
  get 'businesses/show'
  get 'businesses/new'
  get 'businesses/edit'
  get 'organizations/index'
  get 'organizations/show'
  get 'organizations/new'
  get 'organizations/edit'
  get 'suppliers/edit'
  get 'suppliers/show'
  get 'suppliers/index'
  get 'basic_datas/index', to: 'basic_datas#index', as: :basic_index
  root to: 'home#index'
  get "about", to: 'home#about_page_for_user', as: :about_user
  # get "about", :to => "home#about"
  get "thank_you_for_registration_user", :to => 'users#thank_you_for_registration_user'
  get "thank_you_for_registration_supplier", :to => 'suppliers#thank_you_for_registration_supplier'

  devise_scope :user do
    get "users/sign_in", :to => "users/sessions#new"
    post "users/sign_in", :to => "users/sessions#create"
    get "users/sign_out", :to => "users/sessions#destroy"
  end

  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :passwords     => "users/passwords",
    :confirmations => "users/confirmations",
    :unlocks => "users/unlocks"
  }

  devise_scope :supplier do
    get "suppliers/sign_in", :to => "suppliers/sessions#new"
    # post "users/sign_in", :to => "users/sessions#create"
    get "suppliers/sign_out", :to => "suppliers/sessions#destroy"
  end

  devise_for :suppliers, controllers: {
    :registrations => 'suppliers/registrations',
    :passwords     => "suppliers/passwords",
    :confirmations     => "suppliers/confirmations",
    :unlocks     => "suppliers/unlocks"
  }

  delete "projects/:id/:invite_id", to: "projects#invitation_delete", as: :project_invitation_delete

  resources :users do
    resources :projects
    get "projects/:id", to: "projects#accept_project", as: :accept_project
    delete "projects/:id/member_delete/:member_id", to: "projects#member_delete", as: :project_member_delete
    # delete "projects/:id/invitation_delete/:invite_id", to: "projects#invitation_delete", as: :project_invitation_delete
  end
  resources :users, only: [:index, :show, :edit, :update]

  resources :suppliers do
    resources :organizations
    resources :activity_businesses
    # get "business_list", to: "suppliers#business_list", as: :business_list
    delete "suppliers/:supplier_id/organizations/:org_id/:member_id", to: "organizations#member_delete", as: :org_member_delete
    delete "suppliers/:supplier_id/organizations/:org_id/:invite_id", to: "organizations#invite_delete", as: :org_invite_delete
  end
  # resources :suppliers, only: [:index, :show, :edit, :update, :destroy]
  # resources :organizations, only: [:index, :show, :new, :edit, :update, :destroy]
  resources :areas, only: [:index, :show, :edit, :update]

  # resources :projects
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
