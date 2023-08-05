class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
      t.text :contents
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
