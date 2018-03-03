class CreateTranscations < ActiveRecord::Migration[5.0]
  def change
    create_table :transcations do |t|
      t.integer :amount
      t.string :receiver
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.timestamps
    end
  end
end
