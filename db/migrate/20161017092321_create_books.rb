class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.datetime :publish_date
      t.integer :number_of_page
      t.string :author
      t.string :cover
      t.string :description
      t.integer :number_rate_of_book
      t.float :avg_rates
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
