class PersistMessageJob < ApplicationJob
    queue_as :messages

    def perform(app, chats_count, text)
        PersistMessageService.new(app, chats_count, text).persist
    end

end