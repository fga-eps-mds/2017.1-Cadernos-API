Rails.application.routes.draw do
  resources :users
  resources :books
  
  post 'authenticate', to: 'authentication#authenticate'

<<<<<<< HEAD
  get 'users/:id/books' => 'users#books'

  get 'users/:id/books/:title' => 'books#show'

  resources :books

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

=======
  get 'users/:id/books' => 'users#books'  
  
>>>>>>> 8ae95d7... fix routes
end
