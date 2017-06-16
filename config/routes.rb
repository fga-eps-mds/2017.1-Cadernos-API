Rails.application.routes.draw do
  resources :memberships
  resources :invites
  resources :tasks
  resources :users
  resources :books
  resources :categories
  resources :invites
  resources :memberships
  resources :inspirations

  get '/book/search/:keyword' => "books#search"

  post 'authenticate', to: 'authentication#authenticate'
  get 'users/:id/books' => 'users#books'
  get 'users/:id/invites' => 'users#invites'
  get 'users/:id/sent_invites' => 'users#sent_invites'
  get 'users/:id/memberships' => 'users#memberships'
  get 'books/:id/members' => 'books#members'

  post "/books/:id/cover" => "books#set_cover"
  get "/books/:id/tasks" => "books#tasks"
  get "/books/:id/inspirations" => "books#inspirations"

  post "/tasks/:id/picture" => "tasks#set_picture"

  get "/books/:id/full-detail" => "books#full_detail"
end
