Rails.application.routes.draw do
  resources :tasks
  resources :users
  resources :books
  resources :categories

  post 'authenticate', to: 'authentication#authenticate'
  get 'users/:id/books' => 'users#books'

  post "/books/:id/cover" => "books#set_cover"
end
