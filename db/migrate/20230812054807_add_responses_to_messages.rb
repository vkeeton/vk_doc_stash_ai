class AddResponsesToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :response, :text
  end
end
