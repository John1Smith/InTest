class CreateScaleResults < ActiveRecord::Migration
  def change
    create_table :scale_results do |t|
      t.integer :scale_id
      t.integer :user_id
      t.integer :result

      t.timestamps
    end
  end
end
