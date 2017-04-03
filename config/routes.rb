Rails.application.routes.draw do
  resources :users
  get '/users/:id', to: 'users#show'

  post 'authenticate', to: 'authentication#authenticate'

  get 'users/:id/books' => 'users#books'

  get 'users/:id/books/:title' => 'books#show'

  resources :categories
end
