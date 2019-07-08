Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  root to: 'messages#index'
  resources :messages, only: %i[index new create edit update destroy]
end
