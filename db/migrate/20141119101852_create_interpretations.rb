class CreateInterpretations < ActiveRecord::Migration
  def change
    create_table :interpretations do |t|
      t.integer :scale_id
      t.integer :value_from
      t.integer :value_to
      t.string :text

      t.timestamps
    end
  end
end
