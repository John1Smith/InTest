class AddOrderNumberToTests < ActiveRecord::Migration
  def change
    add_column :tests, :order_number, :integer
  end
end
