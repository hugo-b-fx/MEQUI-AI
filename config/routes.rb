Rails.application.routes.draw do
  devise_for :users

  root "pages#home"

  resources :chats, only: [:show] do
    resources :messages, only: [:create]
  end

  get "/chat", to: "chats#show"
end
