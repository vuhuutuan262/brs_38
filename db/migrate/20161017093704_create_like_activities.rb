class CreateLikeActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :like_activities do |t|
      t.boolean :is_like
      t.references :user, foreign_key: true
      t.references :activities, foreign_key: true

      t.timestamps
    end
  end
end
