class PersistChatService

    def initialize(app, chats_count)
		@app = app
		@chats_count = chats_count
    end

    def persist
		chat = @app.chats.new
      	chat.chat_number = @chats_count
    	if chat.save!
			puts chat.to_json
		else      
			@app.update(chats_count: @app.chats.count)
    	end
	end

end