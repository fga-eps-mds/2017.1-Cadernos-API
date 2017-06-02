Rails.application.routes.draw do
  resources :invites
  resources :tasks
  resources :users
  resources :books
  resources :categories
  resources :invites

  post 'authenticate', to: 'authentication#authenticate'
  get 'users/:id/books' => 'users#books'

end
