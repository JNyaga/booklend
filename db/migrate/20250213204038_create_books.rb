class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :first_publish_year
      t.string :isbn
      t.boolean :is_available
      t.string :image_url
      t.text :description

      t.timestamps
    end
    # Add a unique index on isbn to enforce uniqueness at the database level.
    add_index :books, :isbn, unique: true
  end
end
