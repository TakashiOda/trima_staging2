Rails.application.routes.draw do

  get "privacy_policy", to: "static_pages#privacy_policy_en", as: :privacy_policy_en
  get "term_of_service", to: "static_pages#term_of_service_en", as: :term_of_service_en
  get "cansel_policy", to: "static_pages#cansel_policy_en", as: :cansel_policy_en
  get "privacy_policy_jp", to: "static_pages#privacy_policy_jp", as: :privacy_policy_jp
  get "term_of_service_jp", to: "static_pages#term_of_service_jp", as: :term_of_service_jp
  get "term_of_service_for_supplier", to: "static_pages#term_of_service_for_supplier", as: :term_of_service_for_supplier
  get "cansel_policy_jp", to: "static_pages#cansel_policy_jp", as: :cansel_policy_jp

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
    resources :projects do
      get "project_home", to: "trip_managers#home", as: :trip_managers_home
    end
    get "projects/:id", to: "projects#accept_project", as: :accept_project
    delete "projects/:id/member_delete/:member_id", to: "projects#member_delete", as: :project_member_delete
  end
  resources :users, only: [:index, :show, :edit, :update]

  resources :suppliers do
    resources :supplier_profiles
    resources :activity_businesses
    get "dashboard", to: "suppliers#dashboard", as: :dashboard
    get "drafts_activities", to: "activities#drafts_activities", as: :drafts_activities
    get "published_activities", to: "activities#published_activities", as: :published_activities
    get "deleted_activities", to: "activities#deleted_activities", as: :deleted_activities
    resources :activities do
      post "copy_activity", to: "activities#copy_activity", as: :copy_activity
      put "delete_activity", to: "activities#delete_activity", as: :delete_activity
      get "stock_new_first_month", to: "activities#stock_new_first_month", as: :new_stocks_first_month
      get "stock_new_next_month", to: "activities#stock_new_next_month", as: :new_stocks_next_month
      get "stock_new_next2_month", to: "activities#stock_new_next2_month", as: :new_stocks_next2_month
      get "stock_new_next3_month", to: "activities#stock_new_next3_month", as: :new_stocks_next3_month
      get "stock_edit_first_month", to: "activities#stock_edit_first_month", as: :edit_stocks_first_month
      get "stock_edit_next_month", to: "activities#stock_edit_next_month", as: :edit_stocks_next_month
      get "stock_edit_next2_month", to: "activities#stock_edit_next2_month", as: :edit_stocks_next2_month
      get "stock_edit_next3_month", to: "activities#stock_edit_next3_month", as: :edit_stocks_next3_month

    end
  end
  resources :areas, only: [:index, :show, :edit, :update]

end
