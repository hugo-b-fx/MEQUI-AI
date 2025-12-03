Rails.application.routes.draw do
  devise_for :users
<<<<<<< Updated upstream

  root to: "pages#home"

  resources :chats, only: [:index, :show, :create] do
    post :create_message
  end

  post "/quick_matching", to: "matches#quick_create"
  get  "/my_matches", to: "matches#index"
=======

  root to: "pages#home"

  # Matches existants (j'ai viré le doublon quick_matching)
  post "/quick_matching", to: "matches#quick_create"
  get "/my_matches", to: "matches#index"
>>>>>>> Stashed changes
  post "/matching", to: "matches#create"

  resource :profile, only: [:edit, :update]

<<<<<<< Updated upstream
=======
  # Chat IA – un seul chat par user, messages nested
  resource :chat, only: [:show] do
    resources :messages, only: [:create]
  end

  # Health check
>>>>>>> Stashed changes
  get "up" => "rails/health#show", as: :rails_health_check
end
