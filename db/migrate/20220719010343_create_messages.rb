class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :message_number
      t.references :chat, foreign_key: true
      t.timestamps
    end
  end
end
