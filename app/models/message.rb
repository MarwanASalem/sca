class Message < ApplicationRecord
    belongs_to :chat

    # settings do
    #   mappings dynamic: false do
    #     indexes :chat_id, index: :not_analyzed
    #     indexes :text, type: :string, analyzer: :english
    #   end
    # end

    def self.search(query)
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: query,
              fields: ['title^10', 'text']
            }
          }
        }
      )
      end      
end
