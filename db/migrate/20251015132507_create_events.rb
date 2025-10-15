class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :location
      t.datetime :start_date
      t.integer :duration
      t.references :events, :admin, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
