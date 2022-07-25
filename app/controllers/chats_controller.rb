class ChatsController < ApplicationController
    before_action :set_app

    def index
        render :json => {
            success: true,
            data: {
                messages: @app.chats.to_json
            }
        }
    end
    
    def create
        @app.update(chats_count: @app.chats_count + 1)
        PersistChatJob.perform_later(@app, @app.chats_count)
        # PersistChatWorker.perform_async(@app)
        render :json => {
            success: true,
            data: {
                chat_number: @app.chats_count
            }
        }
    end

    def show
        chat = @app.chats.find_by(chat_number: params[:chat_number])
        render :json => {
            success: true,
            data: {
                chat: chat.to_json
            }
        }
    end
    
    private

    def set_app
        @app = Application.find_by(token: params[:token])
    end    
end
