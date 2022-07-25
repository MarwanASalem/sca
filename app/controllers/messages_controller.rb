class MessagesController < ApplicationController
    before_action :set_chat

    def index
        render :json => {
            success: true,
            data: {
                messages: @chat.messages.to_json
            }
        }
    end
    
    def create
        @chat.update(messages_count: @chat.messages_count + 1)
        PersistMessageJob.perform_later(@chat, @chat.messages_count, params[:message])
        render :json => {
            success: true,
            data: {
                message_number: @chat.messages_count
            }
        }
    end
    
    def show
        message = @chat.messages.find_by(message_number: params[:message_number])
        render :json => {
            success: true,
            data: {
                message: message.to_json
            }
        }
    end
    
    def search
        messages = @chat.messages.search params[:query]
        chat_message = []
        messages.each do |message|
            if message.chat_id == @chat.id
                chat_message.push(message.message_number)
            end
        end
        
        render :json => {
            success: true,
            data: {
                messages_numbers: chat_message
            }
        }
    end

    private

    def set_app
        @app = Application.find_by(token: params[:token])
    end   

    def set_chat
        set_app
        @chat = @app.chats.find_by(chat_number: params[:chat_number])
    end  
    
end
