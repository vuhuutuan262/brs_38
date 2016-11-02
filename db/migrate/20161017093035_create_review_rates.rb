class CreateReviewRates < ActiveRecord::Migration[5.0]
  def change
    create_table :review_rates do |t|
      t.text :content
      t.integer :number_rate_of_user, default: 0
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
