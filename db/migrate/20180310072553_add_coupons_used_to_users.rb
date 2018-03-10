class AddCouponsUsedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :coupons_used, :text, array:true, default: []
  end
end
