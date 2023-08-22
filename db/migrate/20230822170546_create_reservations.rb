class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :code, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :adults, null: false, default: 0
      t.integer :children, null: false, default: 0
      t.integer :infants, null: false, default: 0
      t.string :status, null: false
      t.string :host_currency, null: false
      t.decimal :payout_price, precision: 9, scale: 2
      t.decimal :security_price, precision: 9, scale: 2
      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end

    add_index :reservations, :code, unique: true
  end
end
