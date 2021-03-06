Rails.application.routes.draw do

  # get 'supplier_bookeditems/index'
  # get 'book_activities/new'
  # get 'book_activities/edit'
  get "privacy_policy", to: "static_pages#privacy_policy_en", as: :privacy_policy_en
  get "term_of_service", to: "static_pages#term_of_service_en", as: :term_of_service_en
  get "cansel_policy", to: "static_pages#cansel_policy_en", as: :cansel_policy_en
  get "privacy_policy_jp", to: "static_pages#privacy_policy_jp", as: :privacy_policy_jp
  get "term_of_service_jp", to: "static_pages#term_of_service_jp", as: :term_of_service_jp
  get "term_of_service_for_supplier", to: "static_pages#term_of_service_for_supplier", as: :term_of_service_for_supplier
  get "cansel_policy_jp", to: "static_pages#cansel_policy_jp", as: :cansel_policy_jp
  get "about_trima", to: 'static_pages#about_for_user', as: :about_for_user
  get "about_trima_for_supplier", to: 'static_pages#about_for_supplier', as: :about_for_supplier

  get 'basic_datas/index', to: 'basic_datas#index', as: :basic_index
  root to: 'home#index'
  get "thank_you_for_registration_user", :to => 'users#thank_you_for_registration_user'
  get "after_resend_confirmation_user", :to => 'users#after_resend_confirmation_user'
  get "thank_you_for_registration_supplier", :to => 'suppliers#thank_you_for_registration_supplier'
  get "after_resend_confirmation_supplier", :to => 'suppliers#after_resend_confirmation_supplier'
  get "thank_you_for_apply", :to => 'supplier_applies#thank_you_for_apply'
  get "download_supplier_docs", :to => 'supplier_applies#download_supplier_docs', as: :download_supplier_docs

  resources :supplier_applies, only: [:index, :show, :new, :create]

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

  devise_for :admins, controllers: {
    :sessions      => 'admins/sessions',
    :passwords     => 'admins/passwords',
    :registrations => 'admins/registrations',
    :unlocks       => "suppliers/unlocks"
  }


  resources :projects do
    resources :charges
    get "project_home", to: "trip_managers#home", as: :trip_managers_home
    get "project_search_home", to: "trip_managers#search_home", as: :search_home
    get "cart", to: "trip_managers#cart", as: :cart
    get "thank_you_payment", to: "trip_managers#thank_you_payment", as: :thank_you_payment
    get "purchase_list", to: "trip_managers#purchase_list", as: :purchase_list
    get "favorite_list", to: "trip_managers#favorite_list", as: :favorite_list
    get "activity/:activity_id", to: "trip_managers#activity_detail", as: :activity_detail
    post "activity/:activity_id/favorite_activity", to: "favorite_activities#create", as: :favorite_activity
    delete "activity/:activity_id/favorite_activity", to: "favorite_activities#destroy"
    post "activities/:activity_id/book_activities", to: "book_activities#create", as: :book_activity_create
    delete "activities/:activity_id/book_activities/:id", to: "book_activities#destroy", as: :book_activity_delete
    # project_members
    get "members", to: "trip_managers#members_index", as: :members
    get "members/new", to: "trip_managers#members_new", as: :new_members
    post "members", to: "trip_managers#members_create"
    get "members/:id/edit", to: "trip_managers#members_edit", as: :edit_members
    patch "members/:id", to: "trip_managers#members_update", as: :update_member_path
    delete "members/:id", to: "trip_managers#members_delete", as: :delete_members
  end

  delete "projects/:id/:invite_id", to: "projects#invitation_delete", as: :project_invitation_delete
  get "projects/:id", to: "projects#accept_project", as: :accept_project
  delete "projects/:id/member_delete/:member_id", to: "projects#member_delete", as: :project_member_delete


  resources :users, only: [:index, :show, :edit, :update]

  resources :suppliers do
    resources :supplier_profiles
    resources :activity_businesses, only: [:index, :new, :create, :edit, :destroy]
    put '/activity_businesses/:id/edit', to: 'activity_businesses#update', as: 'update_activity_business'
    get "dashboard", to: "suppliers#dashboard", as: :dashboard
    get "drafts_activities", to: "activities#drafts_activities", as: :drafts_activities
    get "published_activities", to: "activities#published_activities", as: :published_activities
    get "deleted_activities", to: "activities#deleted_activities", as: :deleted_activities
    get "bookeditems", to: "supplier_bookeditems#index_future", as: :bookeditem_index_future
    get "bookeditems_past", to: "supplier_bookeditems#index_past", as: :bookeditem_index_past
    get "bookeditems_all", to: "supplier_bookeditems#index_all", as: :bookeditem_index_all
    get "bookeditems/:id", to: "supplier_bookeditems#show", as: :bookeditem
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

  get "activity_detail/:activity_id", to: "trip_managers#activity_detail", as: :activity_detail

  resources :admins
  get "supplier_index", to: "admins#supplier_index", as: :supplier_index
  get "supplier_approved_list", to: "admins#supplier_approved_list", as: :supplier_approved_list
  get "supplier_waiting_list", to: "admins#supplier_waiting_list", as: :supplier_waiting_list
  get "supplier_inputing_list", to: "admins#supplier_inputing_list", as: :supplier_inputing_list
  get "supplier_detail/:supplier_id", to: "admins#supplier_detail", as: :supplier_detail
  patch "supplier_activity_biz_approve/:activity_business_id", to: "admins#supplier_activity_biz_approve", as: :activity_biz_approve
  get "supplier_activity_index", to: "admins#supplier_activity_index", as: :supplier_activity_index
  get "supplier_approved_activity_index", to: "admins#supplier_approved_activity_index", as: :supplier_approved_activity_index
  get "supplier_waiting_activity_index", to: "admins#supplier_waiting_activity_index", as: :supplier_waiting_activity_index
  get "supplier_draft_activity_index", to: "admins#supplier_draft_activity_index", as: :supplier_draft_activity_index
  get "supplier_activity_detail/:activity_id", to: "admins#supplier_activity_detail", as: :supplier_activity_detail
  patch "activity_approve/:activity_id", to: "admins#activity_approve", as: :activity_approve

  resources :areas, only: [:index, :show, :edit, :update]

end
