class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :spot_id
      t.integer :user_id
      t.text :impression
      t.datetime :visit_date
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
