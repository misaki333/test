class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.integer :plan_id
      t.time :time
      t.string :to_go
      t.string :to_do

      t.timestamps
    end
  end
end
