Rails.application.routes.draw do
  root  "static_pages#welcome"
  devise_for :users, controllers: {
         sessions: 'users/sessions',
         passwords: 'users/passwords',
         registrations: 'users/registrations'
 }
 resources :establishments do
   collection do
     get "search_by_name"
     get "general_search"
   end
 end
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
