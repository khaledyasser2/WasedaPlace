class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.date :date, null: false
      t.integer :period, null: false
      t.string :room_number, null: false
      t.timestamps
    end
  end
end
