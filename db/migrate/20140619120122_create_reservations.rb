class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :table, index: true

      t.timestamps
    end
  end
end
