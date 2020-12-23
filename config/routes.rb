Rails.application.routes.draw do
  devise_for :users
  root "welcome#home"
  get '/pages/about', to: "welcome#about"
  resources :users
  
  
end
