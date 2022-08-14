Rails.application.routes.draw do
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  get "users/:id/likes" => "users#likes"


  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"

  get "signup" => "users#new"
  get 'users/index'
  get "users/:id" => "users#show"

  get 'posts/index'

  #get '/' => 'home#top'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#top'
  get 'about' => 'home#about'
  get 'posts/new' => 'posts#new'
  get 'posts/:id'=> 'posts#show'
  post "posts/create" => "posts#create"
  post "posts/:id/update" => "posts#update"
  get "posts/:id/edit" => "posts#edit"

  post "posts/:id/destroy" => "posts#destroy"

end
