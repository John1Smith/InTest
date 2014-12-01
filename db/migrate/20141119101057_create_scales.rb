class CreateScales < ActiveRecord::Migration
  def change
    create_table :scales do |t|
      t.integer :test_id
      t.string :name
      t.string :questions
      t.integer :result
      t.boolean :for_user

      t.timestamps
    end
  end
end
