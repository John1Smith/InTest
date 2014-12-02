class ChangeColumn < ActiveRecord::Migration
  def change
  	 change_column :interpretations, :text, :text, :limit => nil
  end
end
