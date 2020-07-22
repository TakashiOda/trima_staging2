Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  root to: 'home#index'
  get "thank_you_for_registration", :to => 'home#after_registration_send_email'
  get "about", to: 'home#about_page_for_user', as: :about_user
  # get "about", :to => "home#about"
  devise_scope :user do
    get "users/sign_in", :to => "users/sessions#new"
    # post "users/sign_in", :to => "users/sessions#create"
    get "users/sign_out", :to => "users/sessions#destroy"
  end

  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :passwords     => "users/passwords",
    :confirmations     => "users/confirmations",
    :unlocks     => "users/unlocks"
  }

  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
