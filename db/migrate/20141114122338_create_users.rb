class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :sex
      t.integer :age
      t.text :work
      t.text :profession
      t.text :workFunction
      t.integer :workAge

      t.timestamps
    end
  end
end
