class AddNppToResults < ActiveRecord::Migration
  def change
    add_column :results, :npp, :integer
  end
end
