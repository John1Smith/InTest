class AddText2ToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :text2, :string
  end
end
