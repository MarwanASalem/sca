class ChatsController < ApplicationController
    before_action :set_app

    def create
        @app.update(chats_count: @app.chats_count + 1)
        PersistChatJob.perform_later(@app, @app.chats_count)
        # PersistChatWorker.perform_async(@app)
        render :json => {
            success: true,
            data: {
                chat: @app.chats_count
            }
        }
    end
    
    private

    def set_app
        @app = Application.find_by(token: params[:token])
    end    
end
