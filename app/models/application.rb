class Application < ApplicationRecord
    has_many :chats
    validates :name, :token, presence: true
end
