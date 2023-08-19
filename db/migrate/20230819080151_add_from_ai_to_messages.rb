class AddFromAiToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :from_ai, :boolean
  end
end
