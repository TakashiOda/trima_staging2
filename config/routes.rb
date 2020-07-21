Rails.application.routes.draw do
  root to: 'home#index'

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

  # resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
