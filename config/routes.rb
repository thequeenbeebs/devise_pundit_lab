Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  get "users/:id" => "users#show", as: "user"
  get "pages/about" => "notes#about"
  root "notes#index"
end
