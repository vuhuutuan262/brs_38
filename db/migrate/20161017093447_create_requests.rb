class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.boolean :is_approved
      t.string :book_name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
