Rails.application.routes.draw do
  get 'activity_stocks/new'
  get 'activity_stocks/edit'
  get 'basic_datas/index', to: 'basic_datas#index', as: :basic_index
  root to: 'home#index'
  get "about", to: 'home#about_page_for_user', as: :about_user
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
    resources :supplier_profiles
    resources :activity_businesses
    # resources :activities
    # get "suppliers/:supplier_id/activities/stocknew", to: "activities#new", as: :new_activities

    resources :activities do
      get "stocknew", to: "activities#stock_new", as: :new_stocks
      # get "suppliers/:supplier_id/activities/:activity_id/stocknew", to: "activities#stock_new", as: :new_stocks
      post "stocks", to: "activities#stock_create"
      get "stockedit", to: "activities#stock_edit"
      patch "stocks", to: "activities#stock_update"
    end
  end
  # get "activity_agency/:activity_business_id/activities/new", to: "activities#new", as: :new_activities
  # get "activity_agency/:activity_business_id/activities/:id", to: "activities#show", as: :activity
  # patch "activity_agency/:activity_business_id/activities/:id", to: "activities#update"
  # get "activity_agency/:activity_business_id/activities", to: "activities#index", as: :activities
  # post "activity_agency/:activity_business_id/activities", to: "activities#create"
  # get "activity_agency/:activity_business_id/activities/:id/edit", to: "activities#edit", as: :edit_activities
  resources :areas, only: [:index, :show, :edit, :update]

end
