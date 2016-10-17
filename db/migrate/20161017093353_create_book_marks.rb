class CreateBookMarks < ActiveRecord::Migration[5.0]
  def change
    create_table :book_marks do |t|
      t.boolean :read_status
      t.boolean :is_favorite
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
