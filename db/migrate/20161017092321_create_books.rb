class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.datetime :publish_date
      t.integer :number_of_page, default: 1
      t.string :author
      t.string :cover
      t.string :description
      t.integer :number_rate_of_book, default: 0
      t.integer :avg_rates, default: 0
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
