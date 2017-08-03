Rails.application.routes.draw do
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  resources :contacts, only: [:new, :create]
  get 'contact-us', to: 'contacts#new', as: 'contact_us'
end
