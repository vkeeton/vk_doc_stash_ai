Rails.application.routes.draw do
  devise_for :users
  root to: "docs#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :docs, only: %i[index show update create destory] do
    resources :chats, only: :create
  end

  resources :chats, only: %i[index show new update] do
    resources :messages, only: :create do
      resources :responses, only: :create
    end
  end
  get '/doc_delete/:id', to: 'docs#doc_delete', as: :doc_delete
end
