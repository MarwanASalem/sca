class MessagesController < ApplicationController
    before_action :set_chat

    def create
        @chat.update(messages_count: @chat.messages_count + 1)
        PersistMessageJob.perform_later(@chat, @chat.messages_count, params[:message])
        render :json => {
            success: true,
            data: {
                message: @chat.messages_count
            }
        }
    end
    
    def show
        message = @chat.messages.find_by(message_number: show_params[:message_number])
        render :json => {
            success: true,
            data: {
                message: message.message_number
            }
        }
    end
    
    def search
        messages = Message.search params[:query]
        render :json => {
            success: true,
            data: {
                messages: messages.to_json(:only => [ :message_number ])
            }
        }
    end

    private

    def set_app
        @app = Application.find_by(token: params[:token])
    end   

    def set_chat
        set_app
        @chat = @app.chats.find_by(chat_number: params[:chat_id])
    end  
    
    def show_params
        params.permit(:message_number)
    end

end
