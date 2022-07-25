Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  scope 'applications' do
    get "/", to: "applications#index"
    post "/", to: "applications#create"
    scope ':token' do
      get "/", to: "applications#index"
      put "/", to: "applications#update"
      delete "/", to: "applications#destroy"

      scope 'chats' do
        get "/", to: "chats#index"
        post "/", to: "chats#create"

        scope ':chat_number' do
          get "/", to: "chats#show"

          scope 'messages' do
            get "/", to: "messages#index"
            get "/:message_number", to: "messages#show"
            post "/", to: "messages#create"
            put "/search", to: "messages#search"
          end
        end
      end
    end
  end
end
