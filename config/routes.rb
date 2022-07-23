Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # resources :applications do
  #   resources :chats do
  #     resources :messages
  #   end
  # end

  # Applications routes
  scope 'applications' do
    get "/", to: "applications#index"
    post "/", to: "applications#create"
    scope ':token' do
      get "/", to: "applications#index"
      put "/", to: "applications#update"
      delete "/", to: "applications#destroy"

      scope 'chats' do
        get "/", to: "chats#show"
        post "/", to: "chats#create"

        scope ':chat_id' do
          get "/", to: "chats#index"
          get "/messages", to: "messages#show"
          post "/messages", to: "messages#create"

        end
      end
    end
  end

  # # Chats routes
  # get "/chats" to "chats#show"
  # get "/chats/:id" to "chats#index"
  # post "/chats" to "chats#create"
  # put "/chats/:id" to "chats#update"
  # delete "/applications/:token" to "chats#destroy"


end
