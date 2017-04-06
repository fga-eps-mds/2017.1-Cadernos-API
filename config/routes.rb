Rails.application.routes.draw do
  resources :users
  get '/users/:id', to: 'users#show'

  post 'authenticate', to: 'authentication#authenticate'

  get 'users/:id/books' => 'users#books'

  get 'users/:id/books/:title' => 'books#show'

  resources :books
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
