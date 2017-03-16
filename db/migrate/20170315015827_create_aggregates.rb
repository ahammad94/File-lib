class CreateAggregates < ActiveRecord::Migration[5.0]
  def change
    create_table :aggregates do |t|
      t.string :file_name
      t.string :file_type

      t.timestamps
    end
  end
end
