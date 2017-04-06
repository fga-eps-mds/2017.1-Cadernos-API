Rails.application.routes.draw do
  resources :users
  resources :books

  post 'authenticate', to: 'authentication#authenticate'

  get 'users/:id/books' => 'users#books'

  get 'users/:id/books/:id_book' => 'books#show'

  resources :books

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
