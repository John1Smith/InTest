class AddOrderToTest < ActiveRecord::Migration
  def change
    add_column :tests, :order, :integer
  end
end
