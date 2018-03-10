class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :amount
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
