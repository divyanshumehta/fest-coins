class AddDetailsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email, :string
    add_column :users, :promo_code, :string
    add_column :users, :reffered_promo_code, :string
    add_column :users, :coins, :integer
  end
end
