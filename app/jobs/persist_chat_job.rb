class PersistChatJob < ApplicationJob
    queue_as :chats

    def perform(app, chats_count)
        PersistChatService.new(app, chats_count).persist
    end

end