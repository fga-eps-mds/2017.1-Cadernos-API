Rails.application.routes.draw do
  resources :memberships
  resources :invites
  resources :tasks
  resources :users
  resources :books
  resources :categories
  resources :invites
  resources :memberships

  post 'authenticate', to: 'authentication#authenticate'
  get 'users/:id/books' => 'users#books'
  get 'users/:id/invites' => 'users#invites'
  get 'users/:id/sent_invites' => 'users#sent_invites'
  get 'users/:id/memberships' => 'users#memberships'
  get 'books/:id/members' => 'books#members'

end
