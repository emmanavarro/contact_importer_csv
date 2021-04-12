Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'contacts/index'
  resources :contacts do
    collection { post :import }
  end
end
