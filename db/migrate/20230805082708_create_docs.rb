class CreateDocs < ActiveRecord::Migration[7.0]
  def change
    create_table :docs do |t|
      t.string :file_name
      t.string :tag_name
      t.references :user, null: false, foreign_key: true
      t.integer :character_count
      t.text :content
      t.string :file_type
      t.boolean :selected
      t.string :URL

      t.timestamps
    end
  end
end
