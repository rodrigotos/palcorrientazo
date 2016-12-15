Rails.application.routes.draw do
  resources :establishments

  devise_for :users, controllers: {
         sessions: 'users/sessions',
         passwords: 'users/passwords',
         registrations: 'users/registrations'
 }
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
