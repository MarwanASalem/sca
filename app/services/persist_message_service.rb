class PersistMessageService

    def initialize(chat, messages_count, text)
		@chat = chat
        @messages_count = messages_count
        @text = text
    end

    def persist
		message = @chat.messages.new
        message.message_number = @messages_count
        message.text = @text
    	if message.save!
			puts message.to_json
        else
            @chat.update(messages_count: @chat.messages.count)
		end
    end

end