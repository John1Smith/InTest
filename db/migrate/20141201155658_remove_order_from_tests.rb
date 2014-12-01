class RemoveOrderFromTests < ActiveRecord::Migration
  def change
    remove_column :tests, :order, :integer
  end
end
