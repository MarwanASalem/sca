class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    belongs_to :chat

    settings do
      mappings dynamic: false do
        indexes :chat_id, type: 'keyword'
        indexes :text, analyzer: :english
      end
    end

    def self.search(query)
      __elasticsearch__.search(
        {
          "query": {
            "match_phrase_prefix": {
              "text": {
                "query": query
              }
            }
          }
        }
      )
      end      
end
