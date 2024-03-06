class Generate < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.datetime :check_in
      t.datetime :check_out
      t.integer :price
      t.string :guest_name
      t.string :status
      t.bigint :listing_id

      t.timestamps
    end
  end
end
