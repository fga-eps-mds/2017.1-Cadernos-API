Rails.application.routes.draw do
  resources :tasks
  resources :users
  resources :books

  post 'authenticate', to: 'authentication#authenticate'

  get 'users/:id/books' => 'users#books'

  resources :categories
end
