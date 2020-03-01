class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.string :name
      t.date :start_date
      t.date :end_date
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
