class AddConversationTypeToConversations < ActiveRecord::Migration[8.0]
  def change
    add_column :conversations, :conversation_type, :integer, default: 0, null: false
  end
end
